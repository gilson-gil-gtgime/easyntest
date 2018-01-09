//
//  UIViewController+Alert.swift
//  Easyntest
//
//  Created by Gilson Gil on 09/01/18.
//

import UIKit

extension UIViewController {
  func present(error: String) {
    let alert = UIAlertController(title: String.Alert.title, message: error, preferredStyle: .alert)
    let okAction = UIAlertAction(title: String.Alert.okButton, style: .default, handler: nil)
    alert.addAction(okAction)
    DispatchQueue.main.async {
      self.present(alert, animated: true, completion: nil)
    }
  }
}
