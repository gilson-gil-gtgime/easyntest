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
    let coordinator = SimulationResultCoordinator(navigationController: navigationController,
                                                  simulation: simulation)
    coordinator.delegate = self
    coordinator.start()
  }
}

extension SimulationCoordinator: SimulateCoordinatorDelegate {
  func didSimutale(simulation: Simulation) {
    presentSimulation(simulation)
  }
}

extension SimulationCoordinator: SimulationResultCoordinatorDelegate {
  func didTapReset(at coordinator: SimulationResultCoordinator) {
    navigationController.popViewController(animated: true)
  }
}
