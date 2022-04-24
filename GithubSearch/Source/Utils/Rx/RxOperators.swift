//
//  RxOperators.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/24.
//

import RxSwift

extension ObservableType {
  func doOnNext(_ block: @escaping (Element) throws -> Void) -> Observable<Element> {
    self.do(onNext: block)
  }
  
  func doOnNext<Object: AnyObject>(
    with object: Object,
    _ block: @escaping (Object, Element) throws -> Void
  ) -> Observable<Element> {
    self.doOnNext { [weak object] element in
      guard let object = object else { return }
      try block(object, element)
    }
  }
}
