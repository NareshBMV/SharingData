//
//  GenerateInvoiceController.swift
//  OrderApp
//
//  Created by Naresh on 02/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)

class GenerateInvoiceController: BaseViewController,IndicatorInfoProvider,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var totalCostView: UIView!
    @IBOutlet weak var prodListTable: UITableView!
    @IBOutlet weak var generateInvoiceBtn: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var mainHeading: UILabel!


    var itemInfo: IndicatorInfo = "Generate Invoice"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IndicatorInfoProvider
    override func viewWillAppear(_ animated: Bool) {
        noDataLabel.text = "No details found"
        setUp()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedData.sharedInstance.selectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath) as! OrderDetailCell
        cell.selectionStyle = .none
        
        cell.prodTitle.text = SharedData.sharedInstance.selectedProducts[indexPath.row].prodName
        cell.qty.text = String(SharedData.sharedInstance.selectedProducts[indexPath.row].qty)
        cell.prodImage!.sd_setImage(with: URL(string:SharedData.sharedInstance.selectedProducts[indexPath.row].prodImg), completed: nil)
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_IN")
        cell.prodPrice.text = "Price : " + currencyFormatter.string(from:SharedData.sharedInstance.selectedProducts[indexPath.row].prodPrice! as NSNumber)!
        return cell
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
        totalCost.text =  currencyFormatter.string(from:cost as NSNumber)!
    }
    
    @IBAction func generateInvoiceAction(_ sender: Any) {
        
        let invoiceNumber = arc4random_uniform(1000000);
        sharedUserDefaults?.set(totalCost.text, forKey: SharedUserDefaults.Keys.totalCost)
        sharedUserDefaults?.set(String(invoiceNumber), forKey: SharedUserDefaults.Keys.invoiceNumber)
        
        let encodedData = try! JSONEncoder().encode(SharedData.sharedInstance.selectedProducts)
        
        sharedUserDefaults?.set(encodedData, forKey: SharedUserDefaults.Keys.selectedProducts)
        
        SharedData.sharedInstance.selectedProducts.removeAll()

        totalCostView.isHidden = true
        prodListTable.isHidden = true
        generateInvoiceBtn.isHidden = true
        heading.isHidden = true
        mainHeading.isHidden = true
        noDataLabel.isHidden = false
        noDataLabel.text = "Please create new order"
        
        showAlert(title: "Invoice", message: "Your Invoice is generated with invoice number \(invoiceNumber) please open \"Invoice\" application to print", btnTitle: "OK")
        
    }
    
    func setUp() {
        if SharedData.sharedInstance.selectedProducts.count == 0 {
            totalCostView.isHidden = true
            prodListTable.isHidden = true
            generateInvoiceBtn.isHidden = true
            heading.isHidden = true
            mainHeading.isHidden = true
            noDataLabel.isHidden = false
        } else {
            totalCostView.isHidden = false
            prodListTable.isHidden = false
            generateInvoiceBtn.isHidden = false
            heading.isHidden = false
            mainHeading.isHidden = false
            noDataLabel.isHidden = true
            calculateTotalCost()
        }
        prodListTable.reloadData()
    }
}
