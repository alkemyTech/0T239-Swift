//
//  DropDownMenuView.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 11-07-22.
//

import Foundation
import UIKit

protocol DropDownMenuViewProtocol: AnyObject {
    func didTapMenuButton()
}

class DropDownMenuView: UIView {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    weak var delegate: DropDownMenuViewProtocol?
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DropDownMenuView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        delegate?.didTapMenuButton()
    }
}
