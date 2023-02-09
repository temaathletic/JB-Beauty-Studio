//
//  Service.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 03.01.2023.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import CoreImage.CIFilterBuiltins
import SkeletonView
import SDWebImage

class Service {
    
    public var points2 = ""
    public var totalSum = ""
    
    static func Login(login: String, password: String, onSeccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        
        let auth = Auth.auth()
        
        auth.signIn(withEmail: login, password: password) { (result, error) in
            if error != nil {
                onError(error!)
                return
            }
        }
    }
    
    static func Register(login: String, phone: String, password: String, name: String, image: UIImageView, onSeccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        
        let auth = Auth.auth()
        
        auth.createUser(withEmail: login, password: password) { (result, error) in
            if error != nil {
                onError(error!)
                return
            } else if result == result {
                uploadUserDataToFS(name: name, phone: phone, login: login, password: password)
                uploadIamges(image: image)
            }
        }
    }
    
    static func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), complition: @escaping ()->()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            complition()
        }
    }
    
    static func uploadIamges(image: UIImageView) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference(withPath: "users/" + uid)
        guard let imageData = image.image!.jpegData(compressionQuality: 0.3) else { return }
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("\(error)")
                return
            }
        }
    }
    
    static func uploadUserDataToFS(name: String, phone: String, login: String, password: String) {
        
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let randomInviteCode = Int.random(in: 10000..<99999)
        
        if name == "" && login == "" && password == "" {
            print("Пyсто")
        } else if name == "" {
            print("Пyсто")
        } else if login == "" {
            print("Пyсто")
        } else if password == "" {
            print("Пyсто")
        } else {
            db.collection("users").document(uid).setData(["Name" : name, "Phone" : phone, "Login" : login, "Password" : password, "UID" : uid, "InviteCode" : randomInviteCode], merge: true)
            db.collection("usersBonus").document(uid).setData(["Bonus" : 100])
        }
    }
    
    static func updateUserDataToFSFromUP(name: String, phone: String, login: String, image: UIImageView, birthday: String ) {
        
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference(withPath: "users/" + uid)
        guard let imageData = image.image!.jpegData(compressionQuality: 0.3) else { return }
        
        if name == "" && login == "" {
            print("Пyсто")
        } else if name == "" {
            print("Пyсто")
        } else if login == "" {
            print("Пyсто")
        } else {
            db.collection("users").document(uid).setData(["Name" : name, "Phone" : phone, "Login" : login, "Birthday" : birthday], merge: true)
            ref.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("\(error)")
                    return
                }
            }
        }
    }
    
    static func updateUserLocation(location: String) {
        
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(uid).setData(["Location" : location], merge: true)
    }
    
    static func getLocation(completion: @escaping (_ location: String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let location = doc.get("Location") as? String {
                    completion(location)
                } else {
                    print("Error getting field")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
    
    static func getInviteCode(completion: @escaping (_ inviteCode: Int?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let inviteCode = doc.get("InviteCode") as? Int {
                    completion(inviteCode)
                } else {
                    print("Error getting field")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
    
    static func getName(completion: @escaping (_ name: String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let name = doc.get("Name") as? String {
                    completion(name)
                } else {
                    print("Error getting field")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
    
    static func getBirthday(completion: @escaping (_ birthday: String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let birthday = doc.get("Birthday") as? String {
                    completion(birthday)
                } else {
                    print("Error getting field")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
    
    static func getPhone(completion: @escaping (_ phone: String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let phone = doc.get("Phone") as? String {
                    completion(phone)
                } else {
                    print("Error getting field")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
    
    static func editBonusPoint(_ bonusPoint: Int, UID: String) {
        let uid = UID
        let ref = Firestore.firestore().collection("usersBonus").document(uid)
        ref.updateData(["Bonus" : bonusPoint]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Seccess")
            }
        }
    }
    
    static func getEmail(completion: @escaping (_ email: String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let email = doc.get("Login") as? String {
                    completion(email)
                } else {
                    print("Error getting field")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
    
    static func getBonusPoint(completion: @escaping (_ bonusPoint: Int?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("usersBonus").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let bonusPoint = doc.get("Bonus") as? Int {
                    completion(bonusPoint)
                } else {
                    print("Error getting bonus")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
    
    static func downloadImages(photo: UIImageView) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference(withPath: "users/" + uid)
        
        DispatchQueue.global().async {
            ref.getData(maxSize: .max) { data, error in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        photo.image = image
                    }
                } else {
                    print("Error getting image")
                }
            }
        }
    }
    
    static func generateQRCode() -> UIImage? {
        
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        
        let data = uid.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 300, y: 300)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    static func generateQRCodeFromSum(letter: String) -> UIImage? {
        
        let data = letter.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 300, y: 300)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    static func searchUserName(entryNumber: String, completion: @escaping (_ name: String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let name = doc.get("Name") as? String {
                    completion(name)
                } else {
                    print("Error getting field")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
    
    static func searchUserLocation(entryNumber: String, completion: @escaping (_ name: String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let location = doc.get("Location") as? String {
                    completion(location)
                } else {
                    print("Error getting field")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
    
    static func searchUserNumber(entryNumber: String, completion: @escaping (_ name: String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let phone = doc.get("Phone") as? String {
                    completion(phone)
                } else {
                    print("Error getting field")
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }
    }
}

