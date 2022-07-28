//
//  MembersView.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 18-07-22.
//

import Foundation
import UIKit

class MembersView: UIView {
    
    let membersViewModel: MembersViewModelInterface
    var members: [Member]?
    
    init(membersViewModel: MembersViewModelInterface) {
        self.membersViewModel = membersViewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var memberImage: UIImageView = {
        guard let members = members else {
            return UIImageView()
        }
        let imageView = UIImageView(image: UIImage(named: members[0].image))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15.6
        imageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var ourStaffTitle: UILabel = {
        let label = UILabel()
        let text = "¡Nuestro staff!"
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .medium)]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        label.attributedText = attributeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var memberName: UILabel = {
        let label = UILabel()
        guard let members = members else {
            return UILabel()
        }
        let text = members[0].name
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        label.attributedText = attributeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var memberRol: UILabel = {
        let label = UILabel()
        guard let members = members else {
            return UILabel()
        }
        let text = members[0].description
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .light)]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        label.attributedText = attributeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var memberDescription: UILabel = {
        let label = UILabel()
        guard let members = members else {
            return UILabel()
        }
        let text = members[0].largeDescription
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .light)]
        let attributeText = NSAttributedString(string: text, attributes: attribute)
        label.attributedText = attributeText
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleAndImageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.addArrangedSubview(ourStaffTitle)
        stack.addArrangedSubview(memberImage)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var nameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .fill
        stack.distribution = .fill
        stack.addArrangedSubview(memberName)
        stack.addArrangedSubview(memberRol)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var descriptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        stack.addArrangedSubview(nameStackView)
        stack.addArrangedSubview(memberDescription)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MembersCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var seeAllMembersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor(red: 0.0, green: 0.22, blue: 1.0, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("¡Ver todos los miembros!", for: .normal)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.systemGray3.cgColor
        button.layer.shadowOffset = CGSize(width: 0 , height: 4)
        return button
    }()
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        getMembers()
        addSubViews()
        setupConstraints()
    }
    
    private func getMembers() {
        members = membersViewModel.getMembers()
    }
    
    private func addSubViews() {
        addSubview(titleAndImageStackView)
        addSubview(descriptionStackView)
        addSubview(collectionView)
        addSubview(seeAllMembersButton)
    }
    
    private func setupConstraints() {
        titleAndImageStackView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        titleAndImageStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        descriptionStackView.topAnchor.constraint(equalTo: titleAndImageStackView.bottomAnchor, constant: 8).isActive = true
        descriptionStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        descriptionStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 24).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        seeAllMembersButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24).isActive = true
        seeAllMembersButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        seeAllMembersButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
    }
}

extension MembersView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        membersViewModel.getMembers().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MembersCollectionViewCell,
              let members = members else {
            return UICollectionViewCell()
        }
        
        cell.memberImage.image = UIImage(named: members[indexPath.row].image)
        cell.memberName.text = members[indexPath.row].name
        cell.memberRol.text = members[indexPath.row].description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let members = members else {
            return
        }
        memberName.text = members[indexPath.row].name
        memberImage.image = UIImage(named: members[indexPath.row].image)
        memberRol.text = members[indexPath.row].description
        memberDescription.text = members[indexPath.row].largeDescription
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
