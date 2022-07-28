//
//  BienvenidosView.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 11/07/2022.
//

import Foundation
import UIKit


class BienvenidosView: UIView {
    
    lazy var logoImage: UIImageView =  {
        let imageView = UIImageView()
        let image = UIImage(named: "iconWithoutText")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var bienvenidosImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bienvenidosImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        let welcomeMessage = "Hola! Bievenidx"
        let labelFont = UIFont(name: "HelveticaNeue-Bold", size: 22)
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.black,
            .font: labelFont as Any
        ]
        
        let attributeString = NSAttributedString(string: welcomeMessage, attributes: multipleAttributes)
        label.attributedText = attributeString
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    lazy var text: UILabel = {
        let label = UILabel()
        let message = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Adipiscing dignissim ac et eleifend lacus, rhoncus,
dignissim sagittis. Tellus ac a, elementum ut. Tellus a
morbi tincidunt ultricies malesuada eget turpis. Lacus
enim non enim, velit hac turpis interdum arcu.
Suspendisse at vel ultrices amet orci enim lectus
porttitor ut.
"""
        
        let myAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
        let myAttributeMessage = NSAttributedString(string: message, attributes: myAttribute)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        label.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.attributedText = myAttributeMessage
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.setTitle("Contactanos", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor =  UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = CGFloat(8)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.systemGray3.cgColor
        button.layer.shadowOffset = CGSize(width: 0 , height: 4)
        return button
    }()
    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 22
        stack.alignment = .fill
        stack.distribution = .fill
        stack.addArrangedSubview(bienvenidosImage)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(text)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        self.backgroundColor = .clear
        self.addSubview(logoImage)
        self.addSubview(stackView)
        addSubview(contactButton)
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -16).isActive = true
        contactButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24).isActive = true
        contactButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        contactButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
