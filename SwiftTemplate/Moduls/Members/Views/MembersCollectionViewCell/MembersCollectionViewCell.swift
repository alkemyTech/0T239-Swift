//
//  MembersCollectionViewCell.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 18-07-22.
//

import Foundation
import UIKit

class MembersCollectionViewCell: UICollectionViewCell {
    
    lazy var memberImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var memberName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var memberRol: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 7, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .center
        stack.distribution = .fill
        stack.addArrangedSubview(memberName)
        stack.addArrangedSubview(memberRol)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(memberImage)
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            memberImage.topAnchor.constraint(equalTo: topAnchor),
            memberImage.leftAnchor.constraint(equalTo: leftAnchor),
            memberImage.rightAnchor.constraint(equalTo: rightAnchor),
            memberImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        ])
    }
}
