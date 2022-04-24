//
//  BaseViewController.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/21.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
  // MARK: Properties
  var disposeBag = DisposeBag()
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configureLayout()
  }
  
  // MARK: Override points
  func configureLayout() { }
}
