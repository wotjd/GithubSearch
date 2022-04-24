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
  enum Action {
    case search(text: String?)
    case loadMore
  }
  enum Mutation {
    
  }
  struct State {
    @Pulse var repositories: [Repository] = [
      .init(
        id: UUID().uuidString,
        urlString: "https://github.com",
        title: "tesseractr-ocr/tesseract",
        desc: "Tesseract Open Source OCR Engine (main repository)",
        starsCount: 44700,
        language: "C++",
        license: "Apache-2.0 license",
        updatedTime: .init()
      )
    ]
    
    var hasRepository: Bool { self.repositories.isEmpty.toggled }
  }
  
  let initialState = State()
  
//  private let provider = MoyaProvider<GithubAPI>
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .search(text):
      return .empty()
    case .loadMore:
      return .empty()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
      
    }
    return state
  }
}
