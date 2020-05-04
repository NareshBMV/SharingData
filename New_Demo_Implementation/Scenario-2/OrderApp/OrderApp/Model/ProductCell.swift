//
//  ProductCell.swift
//  OrderApp
//
//  Created by Naresh on 02/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var prodID: UILabel!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    
    override func prepareForReuse() {
        setNeedsLayout()
        self.checkMarkButton.isHidden = true
        super.prepareForReuse()
    }
}
