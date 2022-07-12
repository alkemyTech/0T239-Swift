//
//  HomeView.swift
//  SwiftTemplate
//
//  Created by David Duarte on 22/6/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel: HomeViewModelInterface
    
    let bienvenidosView = BienvenidosView(frame: UIScreen.main.bounds)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bienvenidosView)
        return scrollView
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
        self.navigationController?.hidesBarsOnSwipe = true
        self.view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.view.addSubview(scrollView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            // Scroll View constraints
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            bienvenidosView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            bienvenidosView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bienvenidosView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bienvenidosView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }
}
