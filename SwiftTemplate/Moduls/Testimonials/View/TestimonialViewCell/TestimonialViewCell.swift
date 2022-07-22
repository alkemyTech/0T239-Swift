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
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var memberName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var memberDescription: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(memberName)
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
        contentView.backgroundColor = UIColor(red: 253, green: 255, blue: 164, alpha: 1)
        contentView.addSubview(memberImage)
        contentView.addSubview(stack)
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        memberImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        memberImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        stack.leadingAnchor.constraint(equalTo: memberImage.trailingAnchor, constant: 10).isActive = true
        stack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    
    func configure(text: String, image: String, description: String) {
        memberName.text = text
        memberImage.image = UIImage(named: image)
        memberDescription.text = description
    }
}
