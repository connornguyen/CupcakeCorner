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
    
    //Use decimal for the cost, which is more accurate
    var cost: Decimal {
        //$2 per cake
        var cost = Decimal(quantity * 2)
        //Complicated cake cost more
        cost += Decimal(type) / 2
        
        //extraFrosting: $1
        cost += Decimal(quantity)
        //extraPrinkles: $0.5
        cost += Decimal(quantity) / 2
        
        return cost
    }
}
