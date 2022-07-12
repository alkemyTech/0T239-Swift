//
//  HomeView.swift
//  SwiftTemplate
//
//  Created by David Duarte on 22/6/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel: HomeViewModelInterface
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var dropDownMenu: UIView = {
        let menu = DropDownMenuView()
        menu.delegate = self
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupConstraints()
    }
    
    required init(viewModel: HomeViewModelInterface){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: Private methods
private extension HomeViewController {
    func setupViews() {
        self.view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.view.addSubview(scrollView)
        setupDropDownMenu()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            // Scroll View constraints
            
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupDropDownMenu() {
        view.addSubview(dropDownMenu)
        NSLayoutConstraint.activate([
            dropDownMenu.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dropDownMenu.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            dropDownMenu.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension HomeViewController: DropDownMenuViewProtocol {
    func didTapMenuButton() {
        viewModel.presentDropDownMenu(viewController: self)
    }
}
