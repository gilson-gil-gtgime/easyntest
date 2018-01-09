//
//  SimulateViewController.swift
//  Easyntest
//
//  Created by Gilson Gil on 06/01/18.
//

import UIKit
import Cartography

// MARK: - Metrics
extension SimulateViewController {
  static var minimumTextFieldWidth: CGFloat {
    return 300
  }

  static var buttonHeight: CGFloat {
    return .defaultButtonHeight
  }
}

final class SimulateViewController: UIViewController {
  fileprivate lazy var scrollView = UIScrollView()

  fileprivate lazy var scrollViewContentView = UIView()

  fileprivate lazy var containerView = UIView()

  fileprivate lazy var amountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.adjustsFontForContentSizeCategory = true
    label.textAlignment = .center
    label.textColor = UIColor.Easyntest.black
    label.text = String.Simulate.amountLabel
    label.numberOfLines = 0
    return label
  }()

  fileprivate lazy var amountTextField: TextField = {
    let textField = TextField()
    textField.font = UIFont.preferredFont(forTextStyle: .title3)
    textField.adjustsFontForContentSizeCategory = true
    textField.textAlignment = .center
    textField.textColor = UIColor.Easyntest.black
    textField.placeholder = String.Simulate.amountPlaceholder
    textField.keyboardType = .decimalPad
    textField.delegate = self
    return textField
  }()

  fileprivate lazy var maturityLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.adjustsFontForContentSizeCategory = true
    label.textAlignment = .center
    label.textColor = UIColor.Easyntest.black
    label.text = String.Simulate.maturityLabel
    label.numberOfLines = 0
    return label
  }()

  fileprivate lazy var maturityTextField: TextField = {
    let textField = TextField()
    textField.font = UIFont.preferredFont(forTextStyle: .title3)
    textField.adjustsFontForContentSizeCategory = true
    textField.textAlignment = .center
    textField.textColor = UIColor.Easyntest.black
    textField.placeholder = String.Simulate.maturityPlaceholder
    textField.inputView = datePicker
    textField.delegate = self
    return textField
  }()

  fileprivate lazy var rateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.adjustsFontForContentSizeCategory = true
    label.textAlignment = .center
    label.textColor = UIColor.Easyntest.black
    label.text = String.Simulate.rateLabel
    label.numberOfLines = 0
    return label
  }()

  fileprivate lazy var rateTextField: TextField = {
    let textField = TextField()
    textField.font = UIFont.preferredFont(forTextStyle: .title3)
    textField.adjustsFontForContentSizeCategory = true
    textField.textAlignment = .center
    textField.textColor = UIColor.Easyntest.black
    textField.placeholder = String.Simulate.ratePlaceholder
    textField.keyboardType = .decimalPad
    textField.delegate = self
    return textField
  }()

  fileprivate lazy var simulateButton: RoundedButton = {
    let button = RoundedButton()
    button.setTitle(String.Simulate.button, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    button.titleLabel?.adjustsFontForContentSizeCategory = true
    button.addTarget(self, action: #selector(simulateTapped), for: .touchUpInside)
    button.isEnabled = false
    return button
  }()

  fileprivate lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    datePicker.minimumDate = Date()
    datePicker.locale = Locale(identifier: Locale.preferredLanguages[0])
    datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    return datePicker
  }()

  fileprivate var viewModel: SimulateViewModel {
    didSet {
      simulateButton.isEnabled = viewModel.isValid
    }
  }

  init(coordinator: SimulateCoordinator) {
    viewModel = SimulateViewModel(coordinator: coordinator)
    super.init(nibName: nil, bundle: nil)
    setUp()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUp() {
    view.backgroundColor = .white

    addSubviews()
    addConstraints()
    addDismissKeyboardOnTouch()
    observeKeyboardUp()
    observeKeyboardDown()
  }

  private func addSubviews() {
    view.addSubview(scrollView)
    scrollView.addSubview(scrollViewContentView)
    scrollViewContentView.addSubview(containerView)
    containerView.addSubview(amountLabel)
    containerView.addSubview(amountTextField)
    containerView.addSubview(maturityLabel)
    containerView.addSubview(maturityTextField)
    containerView.addSubview(rateLabel)
    containerView.addSubview(rateTextField)
    containerView.addSubview(simulateButton)
  }

  private func addConstraints() {
    // scroll view superview edges
    constrain(scrollView) {
      $0.top == car_topLayoutGuide.asProxy().bottom
      $0.left == $0.superview!.left
      $0.bottom == car_bottomLayoutGuide.asProxy().top
      $0.right == $0.superview!.right
    }

    // scroll view content view
    constrain(scrollViewContentView) {
      $0.edges == $0.superview!.edges
      $0.height >= $0.superview!.superview!.height - UIApplication.shared.statusBarFrame.height
      $0.width == $0.superview!.superview!.width
    }

    // container view, centered, minimum width, no larger than superview
    constrain(containerView) {
      $0.center == $0.superview!.center

      $0.width >= SimulateViewController.minimumTextFieldWidth

      $0.top >= $0.superview!.top
      $0.left >= $0.superview!.left + .defaultHorizontalMargin
      $0.bottom <= $0.superview!.bottom
      $0.right <= $0.superview!.right - .defaultHorizontalMargin
    }

    // align horizontally all container view subviews
    constrain(containerView.subviews) {
      $0.first!.left == $0.first!.superview!.left
      $0.first!.right == $0.first!.superview!.right

      align(left: $0)
      align(right: $0)
    }

    // distribute vertically all container view subviews but button
    constrain(containerView.subviews) {
      $0.first!.top == $0.first!.superview!.top + .defaultVerticalMargin
      $0.last!.bottom == $0.last!.superview!.bottom - .defaultVerticalMargin

      distribute(by: .defaultVerticalMargin, vertically: $0) ~ .defaultHigh
    }

    // button constraints
    constrain(simulateButton, rateTextField) { simulateButton, rateTextField in
      simulateButton.top == rateTextField.bottom + .defaultVerticalMargin * 3

      simulateButton.height >= SimulateViewController.buttonHeight
    }
  }

  private func addDismissKeyboardOnTouch() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
    scrollViewContentView.addGestureRecognizer(tap)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    viewModel = viewModel.reset()
    reset()
  }

  deinit {
    stopObservingKeyboardUp()
    stopObservingKeyboardDown()
    scrollViewContentView.gestureRecognizers?.forEach {
      scrollViewContentView.removeGestureRecognizer($0)
    }
  }
}

// MARK: - Actions
extension SimulateViewController {
  @objc
  func datePickerChanged() {
    viewModel = viewModel.newMaturity(date: datePicker.date)
    maturityTextField.text = viewModel.formattedMaturity
  }

  @objc
  func simulateTapped() {
    simulateButton.startAnimating()
    viewModel.submitTapped {
      DispatchQueue.main.async {
        self.simulateButton.stopAnimating()
      }
    }
  }
}

// MARK: - UITextField Delegate
extension SimulateViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    guard textField == maturityTextField else {
      return
    }
    datePickerChanged()
  }

  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    switch textField {
    case amountTextField:
      let newViewModel: SimulateViewModel
      if string.isEmpty {
        newViewModel = viewModel.removeAmountDigit()
      } else {
        newViewModel = viewModel.insertAmountDigit(string)
      }
      viewModel = newViewModel
      amountTextField.text = viewModel.formattedAmount
    case rateTextField:
      let newViewModel: SimulateViewModel
      if string.isEmpty {
        newViewModel = viewModel.removeRateDigit()
      } else {
        newViewModel = viewModel.insertRateDigit(string)
      }
      viewModel = newViewModel
      rateTextField.text = viewModel.formattedRate
    default:
      break
    }
    return false
  }
}

// MARK: - Private
private extension SimulateViewController {
  func reset() {
    amountTextField.text = nil
    maturityTextField.text = nil
    rateTextField.text = nil
  }
}

// MARK: - Keyboard Handler Protocol
extension SimulateViewController: KeyboardHandler {
  func observeKeyboardUp() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardUp(notification:)),
                                           name: .UIKeyboardWillShow, object: nil)
  }

  func observeKeyboardDown() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDown(notification:)),
                                           name: .UIKeyboardWillHide, object: nil)
  }

  @objc
  func handleKeyboardUp(notification: Notification) {
    let info = userInfo(from: notification)
    scrollView.contentInset = UIEdgeInsets(top: scrollView.contentInset.top,
                                           left: scrollView.contentInset.left,
                                           bottom: info.frame.height,
                                           right: scrollView.contentInset.right)
    scrollView.scrollIndicatorInsets = scrollView.contentInset
  }

  @objc
  func handleKeyboardDown(notification: Notification) {
    scrollView.contentInset = UIEdgeInsets(top: scrollView.contentInset.top,
                                           left: scrollView.contentInset.left,
                                           bottom: 0,
                                           right: scrollView.contentInset.right)
    scrollView.scrollIndicatorInsets = scrollView.contentInset
  }
}
