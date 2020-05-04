//
//  InvoiceController.swift
//  CollectionView
//
//  Created by Naresh on 30/04/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import UIKit

class InvoiceController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
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
        willEnterForeground()
    }
    
    @objc func willEnterForeground() {
        
        if SharedData.sharedInstance.newInvoiceSelectedProducts.count > 0 {
            
            noDataLabel.isHidden = true
            productListView.isHidden = false
            costView.isHidden = false
            mainTitle.isHidden = false
            invoiceNumber.isHidden = false
            printInvoiceBtn.isHidden = false
            
            selectedProducts.removeAll()
            selectedProducts.append(contentsOf: SharedData.sharedInstance.newInvoiceSelectedProducts)
            
            costLabel.text = SharedData.sharedInstance.totalCost
            invoiceNumber.text = "Invoice Number " + SharedData.sharedInstance.invoiceNumber
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "invoice", for: indexPath) as! InvoiceCell
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
