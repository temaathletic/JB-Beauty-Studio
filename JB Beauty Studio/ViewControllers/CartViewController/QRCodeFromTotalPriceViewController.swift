//
//  QRCodeFromTotalPriceViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 05.02.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
import CoreData

protocol DataDelegate {
    func passString(sumString: String)
}

class QRCodeFromTotalPriceViewController: UIViewController {
    
    var dataDelegate: DataDelegate!
    var totalSumDelegate: String = ""
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let textForQRCode: UILabel = {
        let text = UILabel()
        text.text = "Покажите экран телефона \nвашему косметологу"
        text.numberOfLines = 0
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textAlignment = .center
        text.textColor = Color.mainTextColor
        return text
    }()
    
    public lazy var qrCode: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()

    private let phForQRCode: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.layer.cornerRadius = 15
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        button.setTitleColor(Color.mainTextColor!, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = Color.mainRedColor
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    @objc func tap() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MyOrders")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let vc = ShopCartViewController()
        
        do {
            try managedContext.execute(deleteRequest)
            vc.totalCost()
            vc.getAllItem()
            self.navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        qrCode.image = Service.generateQRCodeFromSum(letter: uid)
//        qrCode.image = Service.generateQRCodeFromSum(letter: totalSumDelegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        
        view.backgroundColor = Color.mainBackgroundColor
        
        view.addSubview(logo)
        view.addSubview(phForQRCode)
        
        phForQRCode.addSubview(qrCode)
        phForQRCode.addSubview(textForQRCode)
        
        view.addSubview(button)
        
        logo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-50)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.frame.height / 3)
            make.width.equalTo(view.frame.width / 3)
        }
        
        phForQRCode.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(logo.snp.bottom)
            make.bottom.equalTo(button.snp.top).offset(-30)
        }
        
        qrCode.snp.makeConstraints { make in
            make.centerX.equalTo(phForQRCode)
            make.top.equalTo(phForQRCode).offset(15)
            make.height.equalTo(view.frame.height / 3)
            make.width.equalTo(view.frame.width / 1.4)
        }
        
        textForQRCode.snp.makeConstraints { make in
            make.top.equalTo(qrCode.snp.bottom).offset(20)
            make.left.right.equalTo(phForQRCode)
            make.bottom.equalTo(phForQRCode).inset(10)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
} 

