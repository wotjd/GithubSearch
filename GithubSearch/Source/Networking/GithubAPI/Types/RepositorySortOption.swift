//
//  RepositorySortOption.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/24.
//

import Foundation

extension GithubAPI {
  enum RepositorySortOption: String {
    case stars
    case forks
    case helpWantedIssues = "help-wanted-issues"
    case updated = "updated"
  }
}
