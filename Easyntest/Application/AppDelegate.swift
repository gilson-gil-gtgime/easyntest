//
//  AppDelegate.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var coordinator: AppCoordinator!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window

    coordinator = AppCoordinator(window: window)
    coordinator.start()

    return true
  }
}
