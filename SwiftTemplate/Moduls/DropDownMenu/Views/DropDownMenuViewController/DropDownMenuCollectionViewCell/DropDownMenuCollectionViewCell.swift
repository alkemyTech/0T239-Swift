//
//  DropDownMenuCollectionViewCell.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 11-07-22.
//

import UIKit

class DropDownMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuItemTitle: UILabel!
    @IBOutlet weak var menuItemImage: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(itemTitle: String, itemImage: String) {
        menuItemTitle.text = itemTitle
        menuItemTitle.highlightedTextColor = .red
        menuItemImage.image = UIImage(named: itemImage)?.withTintColor(.black)
        menuItemImage.highlightedImage = UIImage(named: itemImage)?.withTintColor(.red)
    }
}
