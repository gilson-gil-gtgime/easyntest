//
//  KeyboardHandler.swift
//  Easyntest
//
//  Created by Gilson Gil on 06/01/18.
//

import UIKit

protocol KeyboardHandler {
  func observeKeyboardUp()
  func observeKeyboardDown()
  func stopObservingKeyboardUp()
  func stopObservingKeyboardDown()

  func handleKeyboardUp(notification: Notification)
  func handleKeyboardDown(notification: Notification)
  func handleKeyboardUp(notification: Notification, views: [UIView])
  func handleKeyboardDown(notification: Notification, views: [UIView])

  func userInfo(from notification: Notification) -> (frame: CGRect, duration: TimeInterval)
}

extension KeyboardHandler {
  func stopObservingKeyboardUp() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
  }

  func stopObservingKeyboardDown() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }

  func handleKeyboardUp(notification: Notification, views: [UIView]) {
    let frame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
    let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3

    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
      views.forEach {
        $0.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -frame.height)
      }
    }, completion: nil)
  }

  func handleKeyboardDown(notification: Notification, views: [UIView]) {
    let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3

    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
      views.forEach {
        $0.transform = CGAffineTransform.identity
      }
    }, completion: nil)
  }

  func userInfo(from notification: Notification) -> (frame: CGRect, duration: TimeInterval) {
    let frame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
    let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
    return (frame: frame, duration: duration)
  }
}
