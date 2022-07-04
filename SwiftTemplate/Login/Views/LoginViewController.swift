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
    
    let loginViewModel: LoginViewModelInterface
    
    init(loginViewModel: LoginViewModelInterface) {
        self.loginViewModel = loginViewModel
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height + 30, right: 0)
        scrollView.contentInset = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2) {
            self.scrollView.contentInset = .zero
        }
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        loginViewModel.loginUser(email: email, password: password)
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
        let isValidEmail = loginViewModel.validateEmail(email: email)
        let emailLabelMessage = loginViewModel.getEmailLabelMessage(email: email, isValid: isValidEmail)
        showEmailObligatoryField(isValidEmail: isValidEmail, emailLabelMessage: emailLabelMessage)
        enableLoginButton()
        emailObligatoryFieldLabel.isHidden = false
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        guard let password = passwordTextField.text else {
            return
        }
        let isValidPassword = loginViewModel.validatePassword(password: password)
        let passwordLabelMessage = loginViewModel.getPasswordLabelMessage(password: password, isValid: isValidPassword)
        showPasswordObligatoryField(isValidPassword: isValidPassword, passwordLabelMessage: passwordLabelMessage)
        enableLoginButton()
        passwordObligatoryFieldLabel.isHidden = false
    }
    
    private func showEmailObligatoryField(isValidEmail: Bool, emailLabelMessage: String?) {
        emailTextField.layer.borderWidth = isValidEmail ? 0 : 1
        emailTextField.layer.borderColor = isValidEmail ? .none : UIColor.systemRed.cgColor
        emailObligatoryFieldLabel.text = emailLabelMessage
        emailObligatoryFieldLabel.textColor = isValidEmail ? .systemGreen : .systemRed
    }
    
    private func showPasswordObligatoryField(isValidPassword: Bool, passwordLabelMessage: String?) {
        passwordTextField.layer.borderWidth = isValidPassword ? 0 : 1
        passwordTextField.layer.borderColor = isValidPassword ? .none : UIColor.systemRed.cgColor
        passwordObligatoryFieldLabel.text = passwordLabelMessage
        passwordObligatoryFieldLabel.textColor = isValidPassword ? .systemGreen : .systemRed
    }
    
    private func enableLoginButton() {
        let isValidEmail = loginViewModel.validateEmail(email: emailTextField.text ?? "")
        let isValidPassword = loginViewModel.validatePassword(password: passwordTextField.text ?? "")
        loginButton.isEnabled = isValidEmail && isValidPassword
        loginButton.backgroundColor = isValidEmail && isValidPassword ? .systemRed : .systemGray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
