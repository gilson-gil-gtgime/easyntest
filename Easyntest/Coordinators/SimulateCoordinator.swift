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
    DispatchQueue.main.async {
      let viewController = SimulateViewController(coordinator: self)
      if self.navigationController.viewControllers.isEmpty {
        self.navigationController.viewControllers = [viewController]
      } else {
        self.navigationController.pushViewController(viewController, animated: true)
      }
    }
  }
}
