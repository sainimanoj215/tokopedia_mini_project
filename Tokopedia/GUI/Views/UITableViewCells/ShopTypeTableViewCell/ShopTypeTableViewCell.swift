//
//  ShopTypeTableViewCell.swift
//  Tokopedia
//
//  Created by Manoj Saini on 15/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit

let kShopTypeTableViewCell = "ShopTypeTableViewCell"
class ShopTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
