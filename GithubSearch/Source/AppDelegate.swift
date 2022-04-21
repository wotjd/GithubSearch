//
//  AppDelegate.swift
//  GithubSearch
//
//  Created by wotjd on 2022/04/21.
//

import UIKit
import SnapKit
import Reusable
import RxSwift
import RxCocoa
import ReactorKit
import Moya
import Then

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow()
    defer { self.window = window }
    
    window.rootViewController = RepositoryViewController()
    window.makeKeyAndVisible()
    
    return true
  }
}

