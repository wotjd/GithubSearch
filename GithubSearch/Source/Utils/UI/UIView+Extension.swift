//
//  UIView+Extension.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/21.
//

import UIKit

extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach(self.addSubview(_:))
  }
  func addSubviews(_ views: UIView...) {
    views.forEach(self.addSubview(_:))
  }
}

extension UIStackView {
  func addArrangedSubviews(_ views: [UIView]) {
    views.forEach(self.addArrangedSubview(_:))
  }
  func addArrangedSubview(_ views: UIView...) {
    views.forEach(self.addArrangedSubview(_:))
  }
}
