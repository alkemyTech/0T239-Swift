//
//  TestimonialsView.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 21/07/2022.
//

import Foundation
import UIKit


class TestimonialsView: UIView {
    
    private var model = TestimonialsViewModel()
    
    lazy var title: UILabel = {
        let titleLabel = UILabel()
        let titleText = "Testimonios"
        titleLabel.text = titleText
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    lazy var testimonialsList: UITableView = {
        let table = UITableView()
        table.register(TestimonialViewCell.self, forCellReuseIdentifier: TestimonialViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isScrollEnabled = false
        return table
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Ver todos los testimonios", for: .normal)
        button.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = CGFloat(8)
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 15, bottom: 12, right: 15)
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
        stack.spacing = 25
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(testimonialsList)
        stack.addArrangedSubview(button)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tableViewHeightConstraint: NSLayoutConstraint?
    var testimonialHeightKey = "contentSize"
    
    private func setUpView() {
        self.backgroundColor = .clear
        self.addSubview(title)
        self.addSubview(stackView)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == testimonialHeightKey) {
            tableViewHeightConstraint?.constant = testimonialsList.contentSize.height
        }
    }
    
    deinit {
        removeObserver(self, forKeyPath: testimonialHeightKey)
    }
    
    private func setUpConstraints() {
        
        testimonialsList.addObserver(self, forKeyPath: testimonialHeightKey, options: .new, context: nil)
        tableViewHeightConstraint = testimonialsList.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            testimonialsList.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
        ])
        
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tableViewHeightConstraint?.isActive = true
    }
    
}

//MARK: - Extension
extension TestimonialsView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.model.getTestimonials().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TestimonialViewCell.identifier, for: indexPath) as? TestimonialViewCell else {
            return UITableViewCell()
        }
        
        let testimonial = self.model.getTestimonials()[indexPath.row]
        
        cell.configure(text: testimonial.name,
                       image: testimonial.image,
                       description: testimonial.description)
        
        return cell
    }
}
