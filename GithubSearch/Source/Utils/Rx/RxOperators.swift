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

extension ObservableType {
  func distinctUntilChanged<
    K1: Equatable,
    K2: Equatable
  >(
    _ k1: @escaping (Element) throws -> K1,
    _ k2: @escaping (Element) throws -> K2
  ) -> Observable<Element> {
    self.distinctUntilChanged { try k1($0) == k1($1) && k2($0) == k2($1) }
  }
  func distinctUntilChanged<
    K1: Equatable,
    K2: Equatable,
    K3: Equatable
  >(
    _ k1: @escaping (Element) throws -> K1,
    _ k2: @escaping (Element) throws -> K2,
    _ k3: @escaping (Element) throws -> K3
  ) -> Observable<Element> {
    self.distinctUntilChanged {
      try k1($0) == k1($1)
        && k2($0) == k2($1)
        && k3($0) == k3($1)
    }
  }
}
