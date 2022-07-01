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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboard()
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
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        scrollView.contentInset = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
}


