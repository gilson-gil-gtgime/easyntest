//
//  RoundedButton.swift
//  Easyntest
//
//  Created by Gilson Gil on 06/01/18.
//

import UIKit

final class RoundedButton: UIButton {
  override var isEnabled: Bool {
    didSet {
      refreshBackgroundColor()
    }
  }

  override var bounds: CGRect {
    didSet {
      layer.cornerRadius = bounds.height / 2
    }
  }

  init() {
    super.init(frame: .zero)
    setUp()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUp() {
    titleEdgeInsets = UIEdgeInsets(top: 0, left: .defaultHorizontalMargin, bottom: 0, right: .defaultHorizontalMargin)
    setTitleColor(.white, for: .normal)
    addTarget(self, action: #selector(touchDown), for: .touchDown)
    addTarget(self, action: #selector(touchUp), for: .touchUpInside)
    addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
    addTarget(self, action: #selector(touchUp), for: .touchCancel)
  }
}

// MARK: - Actions
extension RoundedButton {
  @objc
  func touchDown() {
    backgroundColor = backgroundColor?.withAlphaComponent(0.8)
  }

  @objc
  func touchUp() {
    refreshBackgroundColor()
  }
}

// MARK: - Private
private extension RoundedButton {
  func refreshBackgroundColor() {
    if isEnabled {
      backgroundColor = UIColor.Easyntest.activeButton
    } else {
      backgroundColor = UIColor.Easyntest.inactiveButton
    }
  }
}

// MARK: - Loading Protocol
extension RoundedButton: LoadingButton {}
