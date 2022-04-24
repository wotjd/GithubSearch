//
//  RepositoryCell.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/22.
//

import UIKit
import Reusable

final class RepositoryCell: UITableViewCell, Reusable {
  // MARK: Constant
  private enum Metric {
    static let stackViewInset = UIEdgeInsets(all: 10)
  }
  private enum Text {
    static let starsText: (Int) -> String = { "\($0) stars" }
  }
  
  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .fill
    $0.distribution = .equalSpacing
    $0.spacing = 6
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  private let titleLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .headline)
    $0.adjustsFontSizeToFitWidth = true
  }
  private let descLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .subheadline)
    $0.numberOfLines = 0
  }
  private let starsLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .caption1)
    $0.adjustsFontSizeToFitWidth = true
  }
  private let languageLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .caption1)
    $0.adjustsFontSizeToFitWidth = true
  }
  private let licenseLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .caption1)
    $0.adjustsFontSizeToFitWidth = true
  }
  private let updateTimeLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .caption1)
    $0.adjustsFontSizeToFitWidth = true
  }
  
  // MARK: init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.addSubview(self.stackView)
    self.stackView.addArrangedSubviews(
      self.titleLabel,
      self.descLabel,
      self.starsLabel,
      self.languageLabel,
      self.licenseLabel,
      self.updateTimeLabel
    )
    
    self.stackView.setCustomSpacing(3, after: self.starsLabel)
    
    self.stackView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(Metric.stackViewInset)
    }
  }
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  func prepare(_ repository: Repository) {
    self.titleLabel.text = repository.title
    self.descLabel.text = repository.desc
    self.starsLabel.text = Text.starsText(repository.starsCount)
    self.languageLabel.text = repository.language
    self.licenseLabel.text = repository.license
  }
}
