//
//  LoginViewController.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 23-06-22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailObligatoryFieldLabel: UILabel!
    @IBOutlet weak var passwordObligatoryFieldLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    private var isValidEmail = false
    private var isValidPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboard()
        setupTextFields()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
        
    private func setupView() {
        navigationController?.isNavigationBarHidden = true
        loginButton.layer.cornerRadius = 8
    }
    
    private func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(didTapView(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc private func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height + 15, right: 0)
        scrollView.contentInset = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        let homeVC = HomeViewController(viewModel: HomeViewModel())
        homeVC.view.backgroundColor = .systemGray
        navigationController?.present(homeVC, animated: true)
    }
}

// MARK: TextField methods
extension LoginViewController: UITextFieldDelegate {
    
    private func setupTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.layer.cornerRadius = 4
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.isSecureTextEntry = true
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    }
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        guard let email = emailTextField.text else {
            return
        }
        
        isValidEmail = isValidEmail(email: email)
        showEmailObligatoryField(isValidEmail: isValidEmail)
        isEnabledLoginButton()
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        guard let password = passwordTextField.text else {
            return
        }
    
        isValidPassword = isValidPassword(password: password)
        showPasswordObligatoryField(isValidPassword: isValidPassword)
        isEnabledLoginButton()
    }
    
    private func isValidEmail(email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        isValidEmail = NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
        return isValidEmail
    }
    
    private func isValidPassword(password: String) -> Bool {
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{6,25}"
        isValidPassword = NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: password)
        return isValidPassword
    }
    
    private func showEmailObligatoryField(isValidEmail: Bool) {
        emailObligatoryFieldLabel.isHidden = isValidEmail
        emailTextField.layer.borderWidth = isValidEmail ? 0 : 1
        emailTextField.layer.borderColor = isValidEmail ? .none : UIColor.systemRed.cgColor
    }
    
    private func showPasswordObligatoryField(isValidPassword: Bool) {
        passwordObligatoryFieldLabel.isHidden = isValidPassword
        passwordTextField.layer.borderWidth = isValidPassword ? 0 : 1
        passwordTextField.layer.borderColor = isValidPassword ? .none : UIColor.systemRed.cgColor
    }
    
    private func isEnabledLoginButton() {
        loginButton.isEnabled = isValidEmail && isValidPassword
        loginButton.backgroundColor = isValidEmail && isValidPassword ? .systemRed : .systemGray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
