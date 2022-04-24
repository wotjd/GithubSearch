//
//  RepositoryViewReactor.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/22.
//

import RxSwift
import ReactorKit
import Moya

final class RepositoryViewReactor: Reactor {
  private enum Policy {
    static let countPerPage = 30
  }
  
  enum Action {
    case search(text: String?)
    case loadMore
    
    var isSearchAction: Bool {
      guard case .search = self else { return false }
      return true
    }
  }
  enum Mutation {
    case setSearchResult(
      query: String?,
      repositories: [Repository],
      currentPage: Int?
    )
    case appendSearchResult(
      repositories: [Repository],
      updatedPage: Int
    )
    case setIsLoading(Bool)
    case setHasError
  }
  struct State {
    var currentQuery: String? = nil
    var currentPage: Int? = nil
    @Pulse var repositories: [Repository] = []
    var isLoading = false
    var hasError = false
    
    var canLoadMore: Bool { self.isLoading.toggled && self.hasError.toggled }
    var hasNoRepository: Bool { self.repositories.isEmpty }
    var shouldShowPlaceholder: Bool { self.hasError || self.hasNoRepository }
  }
  
  let initialState = State()
  
  private let provider = MoyaProvider<GithubAPI>()
  private let jsonDecoder = JSONDecoder().then {
    $0.keyDecodingStrategy = .convertFromSnakeCase
    $0.dateDecodingStrategy = .iso8601
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .search(text):
      let resetSearchResult = Observable<Mutation>
        .just(.setSearchResult(query: nil, repositories: [], currentPage: nil))
      let setSearchResult: Observable<Mutation>
      if let query = text, query.isEmpty.toggled {
        let page = 1
        setSearchResult = self.search(query: query, at: page)
          .map {
            Mutation.setSearchResult(
              query: query,
              repositories: $0.items,
              currentPage: page
            )
          }
          .catchAndReturn(.setHasError)
          .asObservable()
          .take(until: self.action.filter(\.isSearchAction))
      } else {
        setSearchResult = .empty()
      }
      return .concat(
        .just(Mutation.setIsLoading(true)),
        resetSearchResult,
        setSearchResult,
        .just(Mutation.setIsLoading(false))
      )
    case .loadMore:
      guard
        self.currentState.canLoadMore,
        let query = self.currentState.currentQuery,
        let nextPage = self.currentState.currentPage.map({ $0 + 1 })
      else { return .empty() }
      let appendSearchResult = self.search(query: query, at: nextPage)
        .map {
          Mutation.appendSearchResult(
            repositories: $0.items,
            updatedPage: nextPage
          )
        }
        .asObservable()
        .catch({ _ in .empty() })
        .take(until: self.action.filter(\.isSearchAction))
      return .concat(
        .just(Mutation.setIsLoading(true)),
        appendSearchResult,
        .just(Mutation.setIsLoading(false))
      )
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case let .setSearchResult(query, repositories, currentPage):
      state.hasError = false
      state.currentQuery = query
      state.repositories = repositories
      state.currentPage = currentPage
    case let .appendSearchResult(repositories, updatedPage):
      guard state.currentPage.map({ $0 < updatedPage }) ?? false else { break }
      state.repositories.append(contentsOf: repositories)
      state.currentPage = updatedPage
    case let .setIsLoading(bool):
      state.isLoading = bool
    case .setHasError:
      state.hasError = true
    }
    return state
  }
  
  private func search(query: String, at page: Int) -> Single<PaginatedResults<Repository>> {
    self.provider.rx
      .request(
        .searchRepository(
          query,
          countPerPage: Policy.countPerPage,
          page: page
        )
      )
      .map(PaginatedResults<Repository>.self, using: self.jsonDecoder)
  }
}
