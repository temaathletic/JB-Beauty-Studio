//
//  MyOrders+CoreDataProperties.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 05.02.2023.
//
//

import Foundation
import CoreData


extension MyOrders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyOrders> {
        return NSFetchRequest<MyOrders>(entityName: "MyOrders")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Int64
    @NSManaged public var quantity: Int64

}

extension MyOrders : Identifiable {

}
