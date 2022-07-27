//
//  RegisterView.swift
//  SwiftTemplate
//
//  Created by Jose on 23/06/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordRepeatField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailObligatoryFieldLabel: UILabel!
    
    @IBAction func signUpAction(_ sender: Any) {
        guard passwordField.text == passwordRepeatField.text,
              let nameText = nameField.text,
              let emailText = emailField.text,
              let passwordText = passwordField.text
             else { return }
        let newUser = NewUser(name: nameText, email: emailText, password: passwordText)
        signupviewmodel.register(user: newUser, from: self)
    }
    
    @IBAction func navigateToLoginAction(_ sender: Any) {
        self.signupviewmodel.navigateToLogin(from: self)
    }
    
    let signupviewmodel: SignUpViewModelInterface & ValidationInterface
    
    init(signupviewmodel: SignUpViewModelInterface & ValidationInterface) {
        self.signupviewmodel = signupviewmodel
        super.init(nibName: "SignUpView", bundle: nil)
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
        navigationController?.isNavigationBarHidden = true
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    private func setupView() {
        registerButton.layer.cornerRadius = 8
        nameField.layer.cornerRadius = 8
        nameField.layer.borderWidth = 0
        emailField.layer.cornerRadius = 8
        emailField.layer.borderWidth = 0
        passwordField.layer.cornerRadius = 8
        passwordField.layer.borderWidth = 0
        passwordRepeatField.layer.cornerRadius = 8
        passwordRepeatField.layer.borderWidth = 0
        registerButton.titleEdgeInsets.top = 10
        registerButton.titleEdgeInsets.bottom = 10
        registerButton.titleEdgeInsets.left = 10
        registerButton.titleEdgeInsets.right = 10
        registerButton.isEnabled = false
        registerButton.backgroundColor = .gray
        
        passwordField.isSecureTextEntry = true
        passwordRepeatField.isSecureTextEntry = true

        emailObligatoryFieldLabel.isHidden = true
    }
    
    private func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height + 20, right: 0)
        scrollView.contentInset = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
}

//MARK: Textfields delegate to validate form.
extension SignUpViewController: UITextFieldDelegate {
    
    private func setupTextFields() {
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        passwordRepeatField.delegate = self
        emailField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        passwordRepeatField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    }
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        guard let email = emailField.text else {
            return
        }
        let isValidEmail = signupviewmodel.validateEmail(email: email)
        let emailLabelMessage = signupviewmodel.getEmailLabelMessage(email: email, isValid: isValidEmail)
        showEmailObligatoryField(isValidEmail: isValidEmail, emailLabelMessage: emailLabelMessage)
        print(emailLabelMessage)
        enableLoginButton()
        emailObligatoryFieldLabel.isHidden = false
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        guard let password = passwordField.text , let passwordRepeat = passwordRepeatField.text else {
            return
        }
        let isValidPassword = signupviewmodel.validatePassword(password: password)
        let isValidRepeatPassword = signupviewmodel.validatePassword(password: passwordRepeat)
        let passwordLabelMessage = signupviewmodel.getPasswordLabelMessage(password: password, isValid: isValidPassword)
        let passwordRepeatLabelMessage = signupviewmodel.getPasswordLabelMessage(password: passwordRepeat, isValid: isValidRepeatPassword)
        emailObligatoryFieldLabel.isHidden = false
        enableLoginButton()
        showPasswordObligatoryField(isValidPassword: isValidRepeatPassword, passwordLabelMessage: passwordRepeatLabelMessage)
        showPasswordObligatoryField(isValidPassword: isValidPassword, passwordLabelMessage: passwordLabelMessage)
    }
    
    private func showEmailObligatoryField(isValidEmail: Bool, emailLabelMessage: String?) {
        emailField.layer.borderWidth = isValidEmail ? 0 : 1
        emailField.layer.borderColor = isValidEmail ? .none : UIColor.systemRed.cgColor
        emailObligatoryFieldLabel.text = emailLabelMessage
        emailObligatoryFieldLabel.textColor = isValidEmail ? .systemGreen : .systemRed
    }
    
    private func showPasswordObligatoryField(isValidPassword: Bool, passwordLabelMessage: String?) {
        passwordField.layer.borderWidth = isValidPassword ? 0 : 1
        passwordField.layer.borderColor = isValidPassword ? .none : UIColor.systemRed.cgColor
        
        passwordRepeatField.layer.borderWidth = isValidPassword ? 0 : 1
        passwordRepeatField.layer.borderColor = isValidPassword ? .none : UIColor.systemRed.cgColor
        emailObligatoryFieldLabel.text = passwordLabelMessage
        emailObligatoryFieldLabel.textColor = isValidPassword ? .systemGreen : .systemRed
        if (passwordField.text == passwordRepeatField.text){
            emailObligatoryFieldLabel.textColor = .systemGreen
        } else {
            emailObligatoryFieldLabel.textColor = .systemRed
        }
    }
    
    private func enableLoginButton() {
        let isValidEmail = signupviewmodel.validateEmail(email: emailField.text ?? "")
        let isValidPassword = signupviewmodel.validatePassword(password: passwordField.text ?? "")
        let isValidRepeatPassword = signupviewmodel.validatePassword(password: passwordRepeatField.text ?? "")
        if (passwordField.text == passwordRepeatField.text) {
            registerButton.isEnabled = isValidEmail && isValidPassword && isValidRepeatPassword
            registerButton.backgroundColor = isValidEmail && isValidPassword && isValidRepeatPassword ? .systemRed : .systemGray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

// MARK: Actions
extension SignUpViewController {
    
}
