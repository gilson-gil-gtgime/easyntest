//
//  SimulationSummaryCell.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import UIKit
import Cartography

final class SimulationSummaryCell: UITableViewCell {
  fileprivate lazy var resultLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.adjustsFontForContentSizeCategory = true
    label.textAlignment = .center
    label.textColor = UIColor.Easyntest.black
    label.text = String.SimulationResult.resultLabel
    label.numberOfLines = 0
    return label
  }()

  fileprivate lazy var resultValueLabel: UILabel = {
    let label = UILabel()
    let fontDescriptor = UIFont.preferredFont(forTextStyle: .title1).fontDescriptor.withSymbolicTraits(.traitBold)!
    label.font = UIFont(descriptor: fontDescriptor, size: 40)
    label.adjustsFontForContentSizeCategory = true
    label.textAlignment = .center
    label.textColor = .black
    label.numberOfLines = 0
    return label
  }()

  fileprivate lazy var totalProfitLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.adjustsFontForContentSizeCategory = true
    label.textAlignment = .center
    label.textColor = UIColor.Easyntest.black
    label.text = String.SimulationResult.totalProfitLabel
    label.numberOfLines = 0
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
    contentView.addSubview(resultLabel)
    contentView.addSubview(resultValueLabel)
    contentView.addSubview(totalProfitLabel)
  }

  private func addConstraints() {
    constrain(contentView.subviews) {
      $0.first!.top == $0.first!.superview!.top + .defaultVerticalMargin * 2
      $0.first!.left == $0.first!.superview!.left + .defaultHorizontalMargin
      $0.first!.right == $0.first!.superview!.right - .defaultHorizontalMargin

      $0.last!.bottom == $0.last!.superview!.bottom - .defaultVerticalMargin * 2

      distribute(by: .defaultVerticalMargin / 2, vertically: $0)
      align(left: $0)
      align(right: $0)
    }
  }
}

// MARK: - Updatable
extension SimulationSummaryCell: Updatable {
  func update(_ viewModel: SimulationSummaryViewModel) {
    resultValueLabel.text = viewModel.gross

    let profit = "\(String.SimulationResult.totalProfitLabel) \(viewModel.profit)"
    let defaultAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.preferredFont(forTextStyle: .body),
      .foregroundColor: UIColor.Easyntest.black
    ]
    let highlightAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.preferredFont(forTextStyle: .body),
      .foregroundColor: UIColor.Easyntest.activeButton
    ]
    let highlightedRange = (profit as NSString).range(of: viewModel.profit)
    let attr = NSMutableAttributedString(string: profit, attributes: defaultAttributes)
    attr.setAttributes(highlightAttributes, range: highlightedRange)
    totalProfitLabel.attributedText = attr
  }
}
