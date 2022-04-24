//
//  UIKit+Extension.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/24.
//

import UIKit

extension UIEdgeInsets {
  var vertical: CGFloat { self.top + self.bottom }
  
  init(all inset: CGFloat) {
    self.init(top: inset, left: inset, bottom: inset, right: inset)
  }
}
