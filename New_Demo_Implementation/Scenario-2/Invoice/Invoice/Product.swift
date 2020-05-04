//
//  Product.swift
//  Invoice
//
//  Created by Naresh on 02/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

class Product :Codable{
    var prodName:String!
    var prodID:String!
    var prodImg:String!
    var prodPrice:Int!
    var qty:Int!
    
    init(name:String, id:String, image:String, price:Int) {
        prodName = name
        prodID = id
        prodImg = image
        prodPrice = price
        qty = 0
    }
}
