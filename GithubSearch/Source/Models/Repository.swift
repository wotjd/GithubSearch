//
//  Repository.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/22.
//

import Foundation

struct Repository: Decodable {
  enum CodingKeys: String, CodingKey {
    case id, description, language, license
    case urlString = "htmlUrl"
    case title = "fullName"
    case starsCount = "stargazersCount"
    case updatedTime = "updatedAt"
  }
  struct License: Decodable {
    let name: String?
  }
  
  let id: Int
  let urlString: String
  let title: String
  let description: String?
  let starsCount: Int
  let language: String?
  let license: License?
  let updatedTime: Date
  
  var licenseName: String? { self.license?.name }
}
