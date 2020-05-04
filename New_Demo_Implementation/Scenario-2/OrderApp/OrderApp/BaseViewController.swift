//
//  BaseViewController.swift
//  OrderApp
//
//  Created by Naresh on 02/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title : String, message : String, btnTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
