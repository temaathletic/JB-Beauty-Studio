//
//  MyUserData.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 15.01.2023.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation
import UIKit

class Base {
    
    let userDefaults = UserDefaults.standard
    
    static let shared = Base()
    
    struct cartModel: Codable {
        
        var labelLbl: String
        var priceLbl: String
        var quantity: Int
        var description: String {
            return "\(labelLbl), \(priceLbl), \(quantity)"
        }
    }
    
    var orders: [cartModel] {
        
        get {
            if let data = userDefaults.value(forKey: "orders") as? Data {
                return try! PropertyListDecoder().decode([cartModel].self, from: data)
            } else {
                return [cartModel]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                userDefaults.set(data, forKey: "orders")
            }
        }
    }
    
    func saveOrder(label: String, price: String, quantity: Int) {
        let order = cartModel(labelLbl: label, priceLbl: price, quantity: quantity)
        orders.insert(order, at: 0)
    }
    
    func removeOrder(label: String, price: String, quantity: Int) {
        let order = cartModel(labelLbl: label, priceLbl: price, quantity: quantity)
        orders.insert(order, at: 0)
    }
    
}

