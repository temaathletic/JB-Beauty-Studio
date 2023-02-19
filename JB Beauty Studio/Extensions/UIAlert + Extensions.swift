//
//  UIAlert + Extensions.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 11.02.2023.
//
import UIKit

extension UIAlertController {
    
    class func alert(title:String, msg:String, target: UIViewController) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
        (result: UIAlertAction) -> Void in
        })
        target.present(alert, animated: true, completion: nil)
    }
}
