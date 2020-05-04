//
//  SharedUserDefaults.swift
//  OrderApp
//
//  Created by Naresh on 01/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import Foundation

struct SharedUserDefaults {
    static let suiteName = "group.com.iOS.EdgeVerve"
    
    struct Keys {
        static var selectedProducts = "selectedProducts"
        static let totalCost = "totalCost"
        static let invoiceNumber = "invoiceNumber"
    }
}
