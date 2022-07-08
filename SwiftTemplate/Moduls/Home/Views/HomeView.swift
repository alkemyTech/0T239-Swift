//
//  HomeView.swift
//  SwiftTemplate
//
//  Created by David Duarte on 22/6/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel: HomeViewModelInterface

    let demoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
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
        self.demoLabel.text = self.viewModel.getDemoLabel()
    }
    
    func setupConstraints() {
        [ demoLabel ].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        demoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        demoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
