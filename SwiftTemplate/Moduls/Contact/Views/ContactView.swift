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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews()
        setupConstraints()
        hideKeyboard()
    }
    
    private func addSubViews() {
        addSubview(contributeTitle)
        addSubview(donateButton)
        addSubview(contactUsTitle)
        addSubview(fieldsStackView)
        addSubview(sendMessageButton)
    }
    
    private func setupConstraints() {
        
        contributeTitle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contributeTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        
        donateButton.topAnchor.constraint(equalTo: contributeTitle.bottomAnchor, constant: 16).isActive = true
        donateButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        
        contactUsTitle.topAnchor.constraint(equalTo: donateButton.bottomAnchor, constant: 40).isActive = true
        contactUsTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        
        fieldsStackView.topAnchor.constraint(equalTo: contactUsTitle.bottomAnchor, constant: 16).isActive = true
        fieldsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        fieldsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        sendMessageButton.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 24).isActive = true
        sendMessageButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        sendMessageButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
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
