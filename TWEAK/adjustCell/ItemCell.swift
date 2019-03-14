//
//  ItemCell.swift
//  TWEAK
//
//  Created by ujs on 3/5/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(text: String) {
        self.textLabel.text = text
    }
    
//    func setImage(image: UIImage) {
//        self.img.image = image
//    }

}
