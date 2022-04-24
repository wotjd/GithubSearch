//
//  GithubAPI.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/24.
//

import Moya

enum GithubAPI {
  case searchRepository(
    _ query: String,
    sortOption: RepositorySortOption = .stars,
    decendingOrder: Bool = true,
    countPerPage: Int = 30,
    page: Int = 1
  )
}

extension GithubAPI: Moya.TargetType {
  var baseURL: URL { URL(string: "https://api.github.com")! }
  var path: String {
    switch self {
    case .searchRepository:
      return "/search/repositories"
    }
  }
  var method: Method {
    switch self {
    case .searchRepository:
      return .get
    }
  }
  var task: Task {
    switch self {
    case let .searchRepository(
      query,
      sortOption,
      decendingOrder,
      countPerPage,
      page
    ):
      return .requestParameters(
        parameters: [
          "q": query,
          "sort": sortOption.rawValue,
          "order": decendingOrder ? "desc" : "asc",
          "per_page": countPerPage,
          "page": page
        ],
        encoding: URLEncoding.default
      )
    }
  }
  var headers: [String : String]? {
    switch self {
    case .searchRepository:
      return ["Accept": "application/vnd.github.v3+json"]
    }
  }
}
