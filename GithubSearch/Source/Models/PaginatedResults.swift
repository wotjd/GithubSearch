//
//  PaginatedResults.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/24.
//

import Foundation

struct PaginatedResults<T: Decodable>: Decodable {
  enum CodingKeys: String, CodingKey {
    case items, totalCount
    case isIncomplete = "incompleteResults"
  }
  
  let items: [T]
  let totalCount: Int
  let isIncomplete: Bool
}
