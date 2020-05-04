//
//  ProductSummaryCell.swift
//  OrderApp
//
//  Created by Naresh on 02/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import UIKit

protocol OptionButtonsDelegate{
    func checkQuantity(at index:IndexPath)
    func reduceQuantity(at index:IndexPath)

}

class ProductSummaryCell: UITableViewCell {
    @IBOutlet weak var prodImg: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var Qty: UITextField!
    @IBOutlet weak var addQtyBtn: UIButton!
    @IBOutlet weak var removeQtyBtn: UIButton!
    
    var delegate:OptionButtonsDelegate!
    var indexPath:IndexPath!
    
    @IBAction func qtyUpdateAction(_ sender: UIButton) {
        self.delegate?.checkQuantity(at: indexPath)
    }
    
    @IBAction func qtyReduceAction(_ sender: Any) {
        self.delegate?.reduceQuantity(at: indexPath)
    }
}
