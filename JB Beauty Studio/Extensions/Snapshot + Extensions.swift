//
//  Snapshot + Extensions.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 15.01.2023.
//

import Firebase
import FirebaseFirestore
import Foundation

extension QueryDocumentSnapshot {
    
    func decoded<Type: Decodable>() throws -> Type {
        print(data())
        
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(Type.self, from: jsonData)
        return object
    }
}

