//
//  NewsView.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 20-07-22.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    
    let newsViewModel: NewsViewModelInterface
    var news: [News]?
    
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
    
    lazy var newsTitle: UILabel = {
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
        collection.heightAnchor.constraint(equalToConstant: 170).isActive = true
        collection.showsHorizontalScrollIndicator = false
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
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.systemGray3.cgColor
        button.layer.shadowOffset = CGSize(width: 0 , height: 4)
        return button
    }()
    
    lazy var logoAndTitleView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 22
        stack.alignment = .center
        stack.distribution = .fill
        stack.addArrangedSubview(logoImage)
        stack.addArrangedSubview(newsTitle)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var logoTitleAndCollectionView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        stack.addArrangedSubview(logoAndTitleView)
        stack.addArrangedSubview(collectionView)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    lazy var newsAndButtomView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 40
        stack.alignment = .leading
        stack.distribution = .fill
        stack.addArrangedSubview(newsStackView)
        stack.addArrangedSubview(iWantToBeAPartButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(newsViewModel: NewsViewModelInterface) {
        self.newsViewModel = newsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        getNews()
        addSubViews()
        setupConstraints()
    }
    
    private func getNews() {
        news = newsViewModel.getNews()
    }
    
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.addSubview(logoTitleAndCollectionView)
        scrollStackViewContainer.addSubview(newsAndButtomView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
        NSLayoutConstraint.activate([
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoTitleAndCollectionView.topAnchor.constraint(equalTo: scrollStackViewContainer.topAnchor, constant: 10),
            logoTitleAndCollectionView.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor),
            logoTitleAndCollectionView.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsAndButtomView.topAnchor.constraint(equalTo: logoTitleAndCollectionView.bottomAnchor, constant: 16),
            newsAndButtomView.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            newsAndButtomView.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16),
            newsAndButtomView.bottomAnchor.constraint(equalTo: scrollStackViewContainer.bottomAnchor, constant: -40),
        ])
    }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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

