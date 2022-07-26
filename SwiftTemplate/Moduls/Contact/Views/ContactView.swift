//
//  ContactView.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 22-07-22.
//

import Foundation
import UIKit

class ContactView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupKeyboardObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var logoImage: UIImageView =  {
        let imageView = UIImageView()
        let image = UIImage(named: "Logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: 74).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var contributeTitle: UILabel = {
        let label = UILabel()
        let text = "¿Quieres contribuir?"
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .medium)]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        label.attributedText = attributeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var donateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("Donar", for: .normal)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var contactUsTitle: UILabel = {
        let label = UILabel()
        let text = "¡Contactate con nosotros!"
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .medium)]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        label.attributedText = attributeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var fullNameField: UITextField = {
        let textField = UITextField()
        let placeHolderText = "Nombre y Apellido"
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .light),
                         NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributeText = NSAttributedString(string: placeHolderText, attributes: attribute)
        textField.attributedPlaceholder = attributeText
        textField.borderStyle = .roundedRect
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        let placeHolderText = "Email"
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .light),
                         NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributeText = NSAttributedString(string: placeHolderText, attributes: attribute)
        textField.attributedPlaceholder = attributeText
        textField.borderStyle = .roundedRect
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var messageField: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        let text = "Mensaje"
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .light),
                         NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        textView.attributedText = attributeText
        textView.textColor = .lightGray
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        
        textView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var fieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        stack.addArrangedSubview(fullNameField)
        stack.addArrangedSubview(emailField)
        stack.addArrangedSubview(messageField)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var sendMessageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor(red: 0.0, green: 0.22, blue: 1.0, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("Enviar mensaje", for: .normal)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
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
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews()
        setupConstraints()
        hideKeyboard()
    }
    
    private func addSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.addSubview(logoImage)
        scrollStackViewContainer.addSubview(contributeTitle)
        scrollStackViewContainer.addSubview(donateButton)
        scrollStackViewContainer.addSubview(contactUsTitle)
        scrollStackViewContainer.addSubview(fieldsStackView)
        scrollStackViewContainer.addSubview(sendMessageButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollStackViewContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: scrollStackViewContainer.topAnchor, constant: 10),
            logoImage.centerXAnchor.constraint(equalTo: scrollStackViewContainer.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contributeTitle.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 16),
            contributeTitle.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            contributeTitle.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            donateButton.topAnchor.constraint(equalTo: contributeTitle.bottomAnchor, constant: 16),
            donateButton.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            contactUsTitle.topAnchor.constraint(equalTo: donateButton.bottomAnchor, constant: 40),
            contactUsTitle.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            fieldsStackView.topAnchor.constraint(equalTo: contactUsTitle.bottomAnchor, constant: 16),
            fieldsStackView.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            fieldsStackView.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            sendMessageButton.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 24),
            sendMessageButton.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            sendMessageButton.bottomAnchor.constraint(equalTo: scrollStackViewContainer.bottomAnchor, constant: -20)
        ])
    
    }
    
    private func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(didTapView(gesture:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapView(gesture: UITapGestureRecognizer) {
        endEditing(true)
    }
}

extension ContactView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = "Mensaje"
        }
    }
}
