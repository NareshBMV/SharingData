//
//  SharedData.swift
//  OrderApp
//
//  Created by Naresh on 02/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import Foundation
final class SharedData {
    static let sharedInstance = SharedData()
    var selectedProducts:[Product] = []
    var newInvoiceSelectedProducts:[Product] = []
    var totalCost:String = ""
    var invoiceNumber:String = ""
}
