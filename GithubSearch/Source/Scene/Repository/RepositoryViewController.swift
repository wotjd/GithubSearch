//
//  RepositoryViewController.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/21.
//

import UIKit
import ReactorKit
import RxCocoa

final class RepositoryViewController: BaseViewController, ReactorKit.View {
  // MARK: Constant
  private enum Text {
    static let navigationBarTitleText = "Github Search"
    static let searchBarPlaceholderText = "Search Repository"
    static let placeholderText = "No repository found"
  }
  private enum Color {
    static let backgroundColor = UIColor.systemBackground
    static let labelColor = UIColor.label
  }
  
  // MARK: UI
  private let tableView = UITableView().then {
    $0.register(cellType: RepositoryCell.self)
  }
  private let searchBar = UISearchBar().then {
    $0.placeholder = Text.searchBarPlaceholderText
  }
  private let placeholderView = UIView().then {
    $0.backgroundColor = Color.backgroundColor
    $0.isHidden = true
  }
  private let placeholderLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .body)
    $0.text = Text.placeholderText
    $0.textColor = Color.labelColor
    $0.numberOfLines = 1
    $0.adjustsFontSizeToFitWidth = false
  }
  
  // MARK: Layout
  override func configureLayout() {
    self.view.backgroundColor = Color.backgroundColor
    self.navigationController?.navigationBar.topItem?.title = Text.navigationBarTitleText
    self.tableView.tableHeaderView = self.searchBar
    
    self.searchBar.sizeToFit()
    
    self.view.addSubviews(
      self.tableView,
      self.placeholderView
    )
    self.placeholderView.addSubview(self.placeholderLabel)
    
    self.tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    self.placeholderView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    self.placeholderLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.lessThanOrEqualToSuperview()
    }
  }
  
  // MARK: Bind
  func bind(reactor: RepositoryViewReactor) {
    self.searchBar.rx.text
      .throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
      .map(Reactor.Action.search(text:))
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    // TODO: load more
    
    reactor.state.map(\.hasRepository)
      .distinctUntilChanged()
      .observe(on: MainScheduler.asyncInstance)
      .bind(to: self.placeholderView.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    reactor.pulse(\.$repositories)
      .bind(to: self.tableView.rx.items) { tableView, row, element in
        tableView.dequeueReusableCell(for: .init(index: row), cellType: RepositoryCell.self).then {
          $0.prepare(element)
        }
      }
      .disposed(by: self.disposeBag)
  }
}
