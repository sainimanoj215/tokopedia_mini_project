

//
//  ShopTypeCollectionViewCell.swift
//  Tokopedia
//
//  Created by Manoj Saini on 16/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit

let kShopTypeCollectionViewCell = "ShopTypeCollectionViewCell"
class ShopTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var removeImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.removeImgView.layer.cornerRadius = self.removeImgView.bounds.height/2
        self.removeImgView.layer.borderWidth = 1
        self.removeImgView.layer.borderColor = UIColor.darkGray.cgColor
        self.removeImgView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = self.containerView.bounds.height/2
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.darkGray.cgColor
        self.containerView.layer.masksToBounds = true
    }

}
