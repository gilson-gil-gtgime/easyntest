//
//  SimulateCoordinator.swift
//  Easyntest
//
//  Created by Gilson Gil on 06/01/18.
//

import UIKit

protocol SimulateCoordinatorDelegate: class {
  func didSimutale(simulation: Simulation)
}

final class SimulateCoordinator: NSObject, Coordinator {
  let navigationController: UINavigationController

  weak var delegate: SimulateCoordinatorDelegate?

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewController = SimulateViewController(coordinator: self)
    if navigationController.viewControllers.isEmpty {
      navigationController.viewControllers = [viewController]
    } else {
      navigationController.pushViewController(navigationController, animated: true)
    }
  }
}
