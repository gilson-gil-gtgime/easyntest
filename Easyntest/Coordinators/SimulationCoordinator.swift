//
//  SimulationCoordinator.swift
//  Easyntest
//
//  Created by Gilson Gil on 06/01/18.
//

import UIKit

protocol SimulationCoordinatorDelegate: class {
}

final class SimulationCoordinator: NSObject, Coordinator {
  let window: UIWindow
  var navigationController: UINavigationController!

  weak var delegate: SimulationCoordinatorDelegate?

  init(window: UIWindow) {
    self.window = window
  }

  func start() {
    navigationController = UINavigationController()
    navigationController.isNavigationBarHidden = true
    let coordinator = SimulateCoordinator(navigationController: navigationController)
    coordinator.delegate = self
    coordinator.start()
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }

  func presentSimulation(_ simulation: Simulation) {
  }
}

extension SimulationCoordinator: SimulateCoordinatorDelegate {
  func didSimutale(simulation: Simulation) {
    presentSimulation(simulation)
  }
}
