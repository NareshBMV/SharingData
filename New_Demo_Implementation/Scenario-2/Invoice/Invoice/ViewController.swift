//
//  ViewController.swift
//  Invoice
//
//  Created by Naresh on 01/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import UIKit
import SDWebImage

let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var productListView: UITableView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var costView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var printInvoiceBtn: UIButton!
    var selectedProducts : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        willEnterForeground()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func willEnterForeground() {

        if let invoiceNum = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.invoiceNumber), let cost = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.totalCost), let productData = sharedUserDefaults?.data(forKey: SharedUserDefaults.Keys.selectedProducts) {

            noDataLabel.isHidden = true
            productListView.isHidden = false
            costView.isHidden = false
            mainTitle.isHidden = false
            invoiceNumber.isHidden = false
            printInvoiceBtn.isHidden = false
            
            selectedProducts.removeAll()
            selectedProducts.append(contentsOf: try! JSONDecoder().decode(Array<Product>.self, from: productData))
            
            costLabel.text = cost
            invoiceNumber.text = "Invoice Number " + invoiceNum
            
            productListView.reloadData()
        } else {

            noDataLabel.isHidden = false
            productListView.isHidden = true
            costView.isHidden = true
            mainTitle.isHidden = true
            invoiceNumber.isHidden = true
            printInvoiceBtn.isHidden = true        }
    }
    
    @IBAction func printInvoiceAction(_ sender: Any) {
        showAlert(title: "Invoice", message: "Your invoice is successfully Printed...!", btnTitle: "OK")
    }
    
    func showAlert(title : String, message : String, btnTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath) as! ProductCell
        cell.selectionStyle = .none
        
        cell.prodName.text = selectedProducts[indexPath.row].prodName
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_IN")
        cell.prodPrice.text = "Price : " + currencyFormatter.string(from:selectedProducts[indexPath.row].prodPrice! as NSNumber)!
        cell.prodQty.text = String(selectedProducts[indexPath.row].qty)
        cell.prodImg.sd_setImage(with: URL(string: selectedProducts[indexPath.row].prodImg!), completed: nil)
        
        return cell
    }
    

}

