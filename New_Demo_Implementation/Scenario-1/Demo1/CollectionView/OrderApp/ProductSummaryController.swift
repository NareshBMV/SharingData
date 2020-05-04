//
//  ProductSummaryController.swift
//  OrderApp
//
//  Created by Naresh on 02/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProductSummaryController: UIViewController,IndicatorInfoProvider,OptionButtonsDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var noProductLabel: UILabel!
    @IBOutlet weak var summaryList: UITableView!
    @IBOutlet weak var headingLabel: UILabel!
    

    var itemInfo: IndicatorInfo = "Product Summary"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IndicatorInfoProvider
    override func viewWillAppear(_ animated: Bool) {
        
        if SharedData.sharedInstance.selectedProducts.count == 0 {
            headingLabel.isHidden = true
            summaryList.isHidden = true
            totalView.isHidden = true
            noProductLabel.isHidden = false
        } else {
            headingLabel.isHidden = false
            summaryList.isHidden = false
            noProductLabel.isHidden = true
            summaryList.reloadData()
            totalView.isHidden = false
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedData.sharedInstance.selectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summary", for: indexPath) as! ProductSummaryCell        
        cell.delegate = self
        cell.selectionStyle = .none
        cell.indexPath = indexPath
        cell.prodImg!.sd_setImage(with: URL(string: SharedData.sharedInstance.selectedProducts[indexPath.row].prodImg), completed: nil)
        cell.prodName.text = SharedData.sharedInstance.selectedProducts[indexPath.row].prodName
    

        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_IN")
        cell.prodPrice.text = "Price : " + currencyFormatter.string(from:SharedData.sharedInstance.selectedProducts[indexPath.row].prodPrice! as NSNumber)!
        
        if SharedData.sharedInstance.selectedProducts[indexPath.row].qty == 0 {
            SharedData.sharedInstance.selectedProducts[indexPath.row].qty = 1
        }
        
        cell.Qty.text = String(SharedData.sharedInstance.selectedProducts[indexPath.row].qty)
        
        if indexPath.row == SharedData.sharedInstance.selectedProducts.count-1 {
            calculateTotalCost()
        }
        
        return cell
    }

    func checkQuantity(at index: IndexPath) {
        SharedData.sharedInstance.selectedProducts[index.row].qty += 1
        summaryList.reloadRows(at: [index], with: .none)
        calculateTotalCost()
    }
    
    func reduceQuantity(at index: IndexPath) {
        if SharedData.sharedInstance.selectedProducts[index.row].qty == 1 {
            SharedData.sharedInstance.selectedProducts[index.row].qty = 0
            SharedData.sharedInstance.selectedProducts.remove(at: index.row)
            summaryList.reloadData()
            if SharedData.sharedInstance.selectedProducts.count == 0 {
                headingLabel.isHidden = true
                summaryList.isHidden = true
                noProductLabel.isHidden = false
                totalView.isHidden = true
            }
        } else {
            SharedData.sharedInstance.selectedProducts[index.row].qty -= 1
            summaryList.reloadRows(at: [index], with: .none)
        }
        calculateTotalCost()

    }
    
    func calculateTotalCost() {
        var cost = 0
        for prod in SharedData.sharedInstance.selectedProducts {
            cost = cost + (prod.prodPrice * prod.qty)
        }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_IN")
        costLabel.text =  currencyFormatter.string(from:cost as NSNumber)!
    }
}
