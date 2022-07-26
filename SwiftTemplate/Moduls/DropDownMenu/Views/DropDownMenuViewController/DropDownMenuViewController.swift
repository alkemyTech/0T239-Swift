//
//  DropDownMenuViewController.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 11-07-22.
//

import UIKit

protocol DropDownMenuViewControllerInterface: AnyObject {
    func presentView(menuItem: Int)
}

class DropDownMenuViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dropDownMenuViewModel: DropDownMenuViewModelInterface
    weak var delegate: DropDownMenuViewControllerInterface?
    
    init(dropDownMenuViewModel: DropDownMenuViewModelInterface) {
        self.dropDownMenuViewModel = dropDownMenuViewModel
        super.init(nibName: "DropDownMenuViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        didTabBackgroundView()
        setupCollectionView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.clear
        backgroundView.backgroundColor = UIColor.clear
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowColor = UIColor.systemGray3.cgColor
    }
    
    private func didTabBackgroundView() {
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(tapBackgroundView(gesture:)))
        backgroundView.addGestureRecognizer(tapGesture)
    }

    @objc private func tapBackgroundView(gesture: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCell()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "DropDownMenuCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "DropDownMenuCollectionViewCell")
    }
}

extension DropDownMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dropDownMenuViewModel.getMenuItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DropDownMenuCollectionViewCell", for: indexPath) as? DropDownMenuCollectionViewCell else { return UICollectionViewCell() }
        
        let menuItem = dropDownMenuViewModel.getMenuItems()[indexPath.row]
        cell.configureCell(itemTitle: menuItem.title, itemImage: menuItem.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true)
        delegate?.presentView(menuItem: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 5, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
    }
}
