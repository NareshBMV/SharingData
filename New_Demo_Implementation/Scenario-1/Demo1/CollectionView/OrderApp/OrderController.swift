//
//  ViewController.swift
//  OrderApp
//
//  Created by Naresh on 30/04/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage

class OrderController: BaseViewController,UITableViewDelegate,UITableViewDataSource,IndicatorInfoProvider {
    
    @IBOutlet weak var prodListView: UITableView!
    var prodList : [Product] = []
    var itemInfo = IndicatorInfo(title: "Product List")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        prodListView.reloadData()
    }
    
    func setupData() {
        let prod1:Product = Product(name: "Xiomi MI Mix", id: "321343", image: "https://m.media-amazon.com/images/I/5144a1Esn4L._AC_UY218_.jpg", price: 45000)
        let prod2:Product = Product(name: "One Plus 7 Pro", id: "321344", image: "https://m.media-amazon.com/images/I/418MrNhRNHL._AC_UY218_.jpg", price: 64000)
        let prod3:Product = Product(name: "Google Pixel 3a", id: "321345", image: "https://m.media-amazon.com/images/I/41arJU+8nLL._AC_UY218_.jpg", price: 70000)
        let prod4:Product = Product(name: "Samsung Galaxy A30s", id: "321346", image: "https://m.media-amazon.com/images/I/91A85rbe69L._AC_UL320_.jpg", price: 59000)
        let prod5:Product = Product(name: "Apple iPhone 8", id: "321347", image: "https://m.media-amazon.com/images/I/516OlHuFIYL._AC_UL320_.jpg", price: 49000)
        prodList.append(prod1)
        prodList.append(prod2)
        prodList.append(prod3)
        prodList.append(prod4)
        prodList.append(prod5)
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prodList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductCell
        cell.selectionStyle = .none
        
        cell.prodName.text = prodList[indexPath.row].prodName
        cell.prodID.text = "ID " + prodList[indexPath.row].prodID
        cell.prodImage!.sd_setImage(with: URL(string:prodList[indexPath.row].prodImg), completed: nil)
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_IN")
        cell.price.text = "Price : " + currencyFormatter.string(from:prodList[indexPath.row].prodPrice! as NSNumber)!
        
        if SharedData.sharedInstance.selectedProducts.contains(where: {$0 === prodList[indexPath.row]}) {
            cell.checkMarkButton.isHidden = false
        }
        else {
            cell.checkMarkButton.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if SharedData.sharedInstance.selectedProducts.contains(where: {$0 === prodList[indexPath.row]}) {
            
            let index = SharedData.sharedInstance.selectedProducts.index { (brand) -> Bool in
                brand.prodID == prodList[indexPath.row].prodID
            }
            SharedData.sharedInstance.selectedProducts[index!].qty = 0
            SharedData.sharedInstance.selectedProducts.remove(at: index!)
        } else {
            SharedData.sharedInstance.selectedProducts.append(prodList[indexPath.row])
        }
        prodListView.reloadRows(at: [indexPath], with: .none)
    }
}


