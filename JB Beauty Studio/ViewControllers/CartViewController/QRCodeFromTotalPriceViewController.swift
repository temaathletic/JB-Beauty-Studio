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
        let color = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
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
        button.addTarget(self, action: #selector(exitTapoed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let logo = UIImage(named: "logoForQR")
        qrCode.image = Service.generateQRCodeFromSum(letter: uid)
        logo?.addToCenter(of: qrCode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
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
            make.top.equalTo(logo.snp.bottom).inset(40)
            make.bottom.equalTo(button.snp.top).offset(-30)
        }
        
        qrCode.snp.makeConstraints { make in
            make.top.equalTo(phForQRCode).inset(view.frame.height / 15)
            make.centerX.equalTo(phForQRCode)
            make.height.equalTo(view.frame.height / 3)
            make.width.equalTo(view.frame.height / 3)
        }
        
        textForQRCode.snp.makeConstraints { make in
            make.left.right.equalTo(phForQRCode)
            make.height.equalTo(50)
            make.bottom.equalTo(phForQRCode).inset(view.frame.height / 120)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(15)
        }
    }
} 

extension QRCodeFromTotalPriceViewController {
    
    @objc func exitTapoed() {
        Service.deleteVariableTotal()
        dismiss(animated: true, completion: nil)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MyOrders")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
            let vc = ShopCartViewController()
            vc.totalCost()
            vc.getAllItem()
            
            self.navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
}
