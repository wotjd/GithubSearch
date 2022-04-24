//
//  UIScrollView+Rx.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/25.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIScrollView {
  func reachedBottom(margin: CGFloat = 0) -> ControlEvent<Void> {
    ControlEvent(
      events: self.contentOffset
        .filter {
          let visibleHeight = self.base.contentSize.height - self.base.frame.height
          return 0 < self.base.frame.height
            && visibleHeight + self.base.contentInset.vertical <= $0.y + margin
        }
        .map { _ in Void() }
    )
  }
}
