//
//  LoadingButton.swift
//  Easyntest
//
//  Created by Gilson Gil on 08/01/18.
//

import UIKit

protocol LoadingButton: class {
  var bounds: CGRect { get }
  var subviews: [UIView] { get }
  var titleLabel: UILabel? { get }

  func addSubview(_ subview: UIView)

  func startAnimating()
  func stopAnimating()
}

extension LoadingButton {
  func startAnimating() {
    titleLabel?.alpha = 0
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    activityIndicator.frame = CGRect(x: (bounds.width - activityIndicator.bounds.width) / 2,
                                     y: (bounds.height - activityIndicator.bounds.height) / 2,
                                     width: activityIndicator.bounds.width,
                                     height: activityIndicator.bounds.height)
    activityIndicator.startAnimating()
    addSubview(activityIndicator)
  }

  func stopAnimating() {
    subviews
      .filter { $0 is UIActivityIndicatorView }
      .forEach { $0.removeFromSuperview() }
    titleLabel?.alpha = 1
  }
}
