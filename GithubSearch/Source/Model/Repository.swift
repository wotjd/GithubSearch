//
//  Repository.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/22.
//

import Foundation

struct Repository {
  let id: String
  let urlString: String
  let title: String
  let desc: String?
  let starsCount: Int
  let language: String?
  let license: String?
  let updatedTime: Date
}
