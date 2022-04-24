//
//  RepositoryViewController.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/21.
//

import UIKit
import SafariServices
import ReactorKit
import RxCocoa

final class RepositoryViewController: BaseViewController, ReactorKit.View {
  // MARK: Constant
  private enum Text {
    static let navigationBarTitleText = "Github Search"
    static let searchBarPlaceholderText = "Search Repository"
    static let loadingText = "Seaching...🔍"
    static let errorText = "Oops, an error ocurred.\nPlease retry 😢"
    static let placeholderText = "No repository found 🙄"
  }
  private enum Color {
    static let backgroundColor = UIColor.systemBackground
    static let labelColor = UIColor.label
  }
  
  // MARK: UI
  private let tableView = UITableView().then {
    $0.separatorInset = .init(all: 10)
    $0.register(cellType: RepositoryCell.self)
  }
  private let searchController = UISearchController(searchResultsController: nil).then {
    $0.searchBar.placeholder = Text.searchBarPlaceholderText
  }
  private let placeholderView = UIView().then {
    $0.backgroundColor = Color.backgroundColor
    $0.isHidden = true
  }
  private let placeholderLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .body)
    $0.textColor = Color.labelColor
    $0.numberOfLines = 0
  }
  
  private var searchBar: UISearchBar { self.searchController.searchBar }
  
  // MARK: Layout
  override func configureLayout() {
    self.view.backgroundColor = Color.backgroundColor
    if let navigationController = self.navigationController {
      navigationController.navigationBar.prefersLargeTitles = true
      navigationController.navigationBar.topItem?.title = Text.navigationBarTitleText
      self.navigationItem.searchController = self.searchController
      self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
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
    self.tableView.rx.itemSelected
      .doOnNext(with: self.tableView) {
        $0.deselectRow(at: $1, animated: true)
      }
      .withLatestFrom(reactor.state.map(\.repositories)) { $1[$0.item] }
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { ss, repository in
        guard let url = URL(string: repository.urlString) else { return }
        ss.navigationController?.pushViewController(
          SFSafariViewController(url: url).then {
            $0.navigationItem.largeTitleDisplayMode = .never
          },
          animated: true
        )
      }
      .disposed(by: self.disposeBag)
    
    Observable
      .merge(
        self.searchBar.rx.text
          .distinctUntilChanged()
          .map(Reactor.Action.search(text:))
      )
      .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.tableView.rx.reachedBottom(margin: 100)
      .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
      .map { Reactor.Action.loadMore }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    
    reactor.state.distinctUntilChanged(\.isLoading, \.hasError, \.hasNoRepository)
      .map { $0.isLoading ? Text.loadingText : $0.hasError ? Text.errorText : Text.placeholderText }
      .observe(on: MainScheduler.asyncInstance)
      .bind(to: self.placeholderLabel.rx.text)
      .disposed(by: self.disposeBag)
    
    reactor.state.map(\.shouldShowPlaceholder.toggled)
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
