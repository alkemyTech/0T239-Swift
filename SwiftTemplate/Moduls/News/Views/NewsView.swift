//
//  NewsView.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 20-07-22.
//

import Foundation
import UIKit

class NewsView: UIView {
    
    let newsViewModel: NewsViewModelInterface
    var news: [News]?
    
    init(newsViewModel: NewsViewModelInterface) {
        self.newsViewModel = newsViewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var title: UILabel = {
        let label = UILabel()
        let text = "Novedades"
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .medium)]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        label.attributedText = attributeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "newsCell")
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var newsName: UILabel = {
        let label = UILabel()
        let text = "Nombre de la novedad"
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        label.attributedText = attributeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newsDescription: UILabel = {
        let label = UILabel()
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ultricies ullamcorper et bibendum at neque, tellus dolor nibh netus. Varius odio dictum blandit suscipit praesent purus ultrices. Cras suspendisse arcu hendrerit sed faucibus platea. Facilisis molestie quisque ultrices commodo nunc cursus sit nisi. Vivamus sed euismod rutrum placerat ut. Eu in facilisis vestibulum at. Morbi amet mattis sed elementum cursus. Interdum quisque sed"
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .light)]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        label.attributedText = attributeText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var iWantToBeAPartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("¡Quiero ser parte!", for: .normal)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var newsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        stack.addArrangedSubview(newsName)
        stack.addArrangedSubview(newsDescription)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        getNews()
        addSubViews()
        setupConstraints()
    }
    
    private func getNews() {
        news = newsViewModel.getNews()
    }
    
    private func addSubViews() {
        addSubview(title)
        addSubview(newsStackView)
        addSubview(collectionView)
        addSubview(iWantToBeAPartButton)
    }
    
    private func setupConstraints() {
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        newsStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        newsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        newsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        iWantToBeAPartButton.topAnchor.constraint(equalTo: newsStackView.bottomAnchor, constant: 40).isActive = true
        iWantToBeAPartButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        iWantToBeAPartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}

extension NewsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsViewModel.getNews().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? NewsCollectionViewCell,
              let news = news else {
            return UICollectionViewCell()
        }
        
        cell.newsImage.image = UIImage(named: news[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let news = news else {
            return
        }
        newsName.text = news[indexPath.row].name
        newsDescription.text = news[indexPath.row].content
    }
}

