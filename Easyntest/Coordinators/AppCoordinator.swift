//
//  AppCoordinator.swift
//  Easyntest
//
//  Created by Gilson Gil on 06/01/18.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {
  let window: UIWindow

  var coordinators: [Coordinator] = []

  init(window: UIWindow) {
    self.window = window
  }

  func start() {
    let coordinator = SimulationCoordinator(window: window)
    coordinator.delegate = self
    coordinators.append(coordinator)
    coordinator.start()
  }
}

extension AppCoordinator: SimulationCoordinatorDelegate {}
