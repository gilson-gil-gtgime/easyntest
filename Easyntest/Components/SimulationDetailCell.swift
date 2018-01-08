//
//  SimulationDetailCell.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import UIKit
import Cartography

final class SimulationDetailCell: UITableViewCell {
  fileprivate lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.adjustsFontForContentSizeCategory = true
    label.textColor = UIColor.Easyntest.black
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

  fileprivate lazy var valueLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.adjustsFontForContentSizeCategory = true
    label.textAlignment = .right
    label.textColor = UIColor.Easyntest.black
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

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
    contentView.addSubview(titleLabel)
    contentView.addSubview(valueLabel)
  }

  private func addConstraints() {
    constrain(contentView.subviews) {
      $0.first!.top == $0.first!.superview!.top + .defaultVerticalMargin / 5
      $0.first!.left == $0.first!.superview!.left + .defaultHorizontalMargin
      $0.first!.bottom == $0.first!.superview!.bottom - .defaultHorizontalMargin / 5

      $0.last!.right == $0.last!.superview!.right - .defaultVerticalMargin

      distribute(by: .defaultHorizontalMargin, horizontally: $0)
      align(top: $0)
      align(bottom: $0)
    }
  }
}

// MARK: - Updatable
extension SimulationDetailCell: Updatable {
  func update(_ viewModel: SimulationDetailViewModel) {
    titleLabel.text = viewModel.title
    valueLabel.text = viewModel.value
  }
}
