//
//  LoginViewController.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 23-06-22.
//

import Foundation
import UIKit

protocol LoginViewDelegate: AnyObject {
    func enableLoginButton(show: Bool)
    func showEmailObligatoryField(show: Bool, message: String?)
    func showPasswordObligatoryField(show: Bool, message: String?)
}

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
    
    //TO DO
    @IBAction func didTapLogin(_ sender: Any) {
        
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
        loginViewModel.validateEmail(email: email)
        showEmailLabel()
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        guard let password = passwordTextField.text else {
            return
        }
        loginViewModel.validatePassword(password: password)
        showPasswordLabel()
    }
    
    private func showEmailLabel() {
        emailObligatoryFieldLabel.isHidden = false
    }
    
    private func showPasswordLabel() {
        passwordObligatoryFieldLabel.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController: LoginViewDelegate {
    
    func enableLoginButton(show: Bool) {
        loginButton.isEnabled = show
        loginButton.backgroundColor = show ? .systemRed : .systemGray
    }
    
    func showEmailObligatoryField(show: Bool, message: String?) {
        emailTextField.layer.borderWidth = show ? 0 : 1
        emailTextField.layer.borderColor = show ? .none : UIColor.systemRed.cgColor
        emailObligatoryFieldLabel.text = message
        emailObligatoryFieldLabel.textColor = show ? .systemGreen : .systemRed
    }
    
    func showPasswordObligatoryField(show: Bool, message: String?) {
        passwordTextField.layer.borderWidth = show ? 0 : 1
        passwordTextField.layer.borderColor = show ? .none : UIColor.systemRed.cgColor
        passwordObligatoryFieldLabel.text = message
        passwordObligatoryFieldLabel.textColor = show ? .systemGreen : .systemRed
    }
}
