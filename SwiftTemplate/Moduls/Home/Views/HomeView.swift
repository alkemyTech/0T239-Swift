//
//  HomeView.swift
//  SwiftTemplate
//
//  Created by David Duarte on 22/6/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    let viewModel: HomeViewModelInterface
    
    let bienvenidosView = BienvenidosView(frame: UIScreen.main.bounds)
    var membersView: MembersView
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    
    lazy var dropDownMenu: UIView = {
        let menu = DropDownMenuView()
        menu.delegate = self
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    // MARK: Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    required init(viewModel: HomeViewModelInterface, membersViewModel: MembersViewModelInterface) {
        self.viewModel = viewModel
        self.membersView = MembersView(membersViewModel: membersViewModel)
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

        [ scrollView, dropDownMenu ].forEach { subview in
            view.addSubview(subview)
        }
        
        scrollView.addSubview(scrollStackViewContainer)
        
        scrollStackViewContainer.addArrangedSubview(bienvenidosView)
        scrollStackViewContainer.addArrangedSubview(membersView)
    }
    
    func setupConstraints() {
        let margins = view.layoutMarginsGuide
        
        // ScrollView constraints
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: dropDownMenu.topAnchor)
        ])
        // ScrollView's container constraints
        NSLayoutConstraint.activate([
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
                
        // DropDownMenu
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

extension HomeViewController: DropDownMenuViewControllerInterface {
    func presentView(menuItem: Int) {
        viewModel.presentView(viewController: self, menuItem: menuItem)
    }
}
