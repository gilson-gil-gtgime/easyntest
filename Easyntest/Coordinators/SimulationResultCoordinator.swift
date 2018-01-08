//
//  SimulationResultCoordinator.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import UIKit

protocol SimulationResultCoordinatorDelegate: class {
  func didTapReset(at coordinator: SimulationResultCoordinator)
}

final class SimulationResultCoordinator: NSObject, Coordinator {
  let navigationController: UINavigationController
  let simulation: Simulation

  weak var delegate: SimulationResultCoordinatorDelegate?

  init(navigationController: UINavigationController, simulation: Simulation) {
    self.navigationController = navigationController
    self.simulation = simulation
  }

  func start() {
    DispatchQueue.main.async {
      let viewController = SimulationResultViewController(coordinator: self)
      if self.navigationController.viewControllers.isEmpty {
        self.navigationController.viewControllers = [viewController]
      } else {
        self.navigationController.pushViewController(viewController, animated: true)
      }
    }
  }
}
