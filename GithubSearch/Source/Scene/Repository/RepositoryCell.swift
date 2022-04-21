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
    
  }
  
  let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .fill
    $0.distribution = .equalSpacing
    $0.spacing = 8
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  let titleLabel = UILabel().then {
    $0.adjustsFontSizeToFitWidth = true
  }
  let descLabel = UILabel().then {
    $0.adjustsFontSizeToFitWidth = true
  }
  let starsLabel = UILabel().then {
    $0.adjustsFontSizeToFitWidth = true
  }
  let languageLabel = UILabel().then {
    $0.adjustsFontSizeToFitWidth = true
  }
  let licenseLabel = UILabel().then {
    $0.adjustsFontSizeToFitWidth = true
  }
  let updateTimeLabel = UILabel().then {
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
    
    self.stackView.setCustomSpacing(4, after: self.descLabel)
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
    self.starsLabel.text = "\(repository.starsCount)"
    self.languageLabel.text = repository.language
    self.licenseLabel.text = repository.license
  }
}
