//
//  TextField.swift
//  Easyntest
//
//  Created by Gilson Gil on 06/01/18.
//

import UIKit

final class TextField: UITextField {
  static var underlineHeight: CGFloat {
    return 1
  }

  private lazy var underlineLayer: CALayer = {
    let layer = CALayer()
    layer.backgroundColor = UIColor.Easyntest.lightGray.cgColor
    return layer
  }()

  override var bounds: CGRect {
    didSet {
      underlineLayer.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: TextField.underlineHeight)
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
    layer.addSublayer(underlineLayer)
  }
}
