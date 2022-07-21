//
//  NewsCollectionViewCell.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 20-07-22.
//

import Foundation
import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(newsImage)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: topAnchor),
            newsImage.leftAnchor.constraint(equalTo: leftAnchor),
            newsImage.rightAnchor.constraint(equalTo: rightAnchor),
            newsImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
