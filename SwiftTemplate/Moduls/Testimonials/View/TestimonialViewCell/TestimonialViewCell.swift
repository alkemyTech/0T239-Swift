//
//  TestimonialViewCell.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 21/07/2022.
//

import Foundation
import UIKit


class TestimonialViewCell: UITableViewCell {
    
    static let identifier = "TestimonialCell"
    
    lazy var memberImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 150))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var memberName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var memberDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(memberImage)
        stack.addArrangedSubview(memberDescription)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setupConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.selectionStyle = .none
        contentView.backgroundColor = UIColor(red: 253.0 / 255.0, green: 255.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0)
        contentView.addSubview(memberName)
        contentView.addSubview(stack)
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memberName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            memberName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            memberName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            memberName.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stack.topAnchor.constraint(equalTo: memberName.bottomAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    
    func configure(text: String, image: String, description: String) {
        memberName.text = text
        memberImage.image = UIImage(named: image)
        memberDescription.text = "\"\(description)\""
    }
}
