//
//  Order.swift
//  CupcakeCorner
//
//  Created by Apple on 09/08/2024.
//

import Foundation

@Observable
class Order {
    static let types = [ "Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 2
    var speacialRequestEnabled = false {
        didSet {
            extraFrosting = false
            addSprinkles = false
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zipCode = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zipCode.isEmpty {
            return false
        }
        
        return true
    }
}
