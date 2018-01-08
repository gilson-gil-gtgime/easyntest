//
//  SimulationButtonCell.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import UIKit
import Cartography

protocol SimulationButtonCellDelegate: class {
  func didTapReset()
}

// MARK: - Metrics
extension SimulationButtonCell {
  static var buttonHeight: CGFloat {
    return .defaultButtonHeight
  }
}

final class SimulationButtonCell: UITableViewCell {
  fileprivate lazy var resetButton: RoundedButton = {
    let button = RoundedButton()
    button.setTitle(String.SimulationResult.button, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    button.titleLabel?.adjustsFontForContentSizeCategory = true
    button.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
    button.isEnabled = true
    return button
  }()

  weak var delegate: SimulationButtonCellDelegate?

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUp()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUp() {
    selectionStyle = .none

    addSubviews()
    addConstraints()
  }

  private func addSubviews() {
    contentView.addSubview(resetButton)
  }

  private func addConstraints() {
    constrain(resetButton) {
      $0.edges == inset($0.superview!.edges, .defaultHorizontalMargin, .defaultVerticalMargin)
      $0.height >= SimulationButtonCell.buttonHeight
    }
  }
}

// MARK: - Actions
extension SimulationButtonCell {
  @objc
  func resetTapped() {
    delegate?.didTapReset()
  }
}

// MARK: - Updatable
extension SimulationButtonCell: Updatable {
  func update(_ viewModel: Any?) {}
}
