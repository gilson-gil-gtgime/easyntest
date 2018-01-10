//
//  SimulationResultViewController.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import UIKit
import Cartography

final class SimulationResultViewController: UIViewController {
  fileprivate lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()

  fileprivate var viewModel: SimulationResultViewModel

  init(coordinator: SimulationResultCoordinator) {
    viewModel = SimulationResultViewModel(coordinator: coordinator)
    super.init(nibName: nil, bundle: nil)
    setUp()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUp() {
    view.backgroundColor = .white

    viewModel.configurators.forEach {
      tableView.register($0)
    }
    addSubviews()
    addConstraints()
  }

  private func addSubviews() {
    view.addSubview(tableView)
  }

  private func addConstraints() {
    constrain(tableView) {
      $0.edges == $0.superview!.edges
    }
  }
}

// MARK: - Simulation Button Cell Delegate
extension SimulationResultViewController: SimulationButtonCellDelegate {
  func didTapReset() {
    viewModel.didTapReset()
  }
}

// MARK: - UITableView DataSource
extension SimulationResultViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.configurators.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.configurators[section].count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let configurator = viewModel.configurators[indexPath.section][indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: configurator.reuseIdentifier, for: indexPath)
    configurator.update(cell)
    if let buttonCell = cell as? SimulationButtonCell {
      buttonCell.delegate = self
    }
    return cell
  }
}

// MARK: - UITableView Delegate
extension SimulationResultViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return 120
    case 1, 2:
      return 44
    case 3:
      return 60
    default:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    let height = CGFloat(viewModel.footerHeight(for: section))
    return height
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
}
