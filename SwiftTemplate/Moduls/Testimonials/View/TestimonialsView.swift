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
        let myAttribute = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 24)]
        
        let attributeString = NSAttributedString(string: titleText, attributes: myAttribute as [NSAttributedString.Key : Any])
        titleLabel.attributedText = attributeString
        
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
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Ver todos los testimonios", for: .normal)
        button.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        button.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = CGFloat(8)
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 15, bottom: 12, right: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(title)
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
    
    
    private func setUpView() {
        self.backgroundColor = .clear
        self.addSubview(stackView)
    }
    
    
    private func setUpConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
}

//MARK: - Extension
extension TestimonialsView: UITableViewDelegate, UITableViewDataSource{
    
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
