//
//  QRCodeViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit

class QRCodeViewController: UIViewController {
    
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
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 25)
        text.textAlignment = .center
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let qrCode: UIImageView = {
        let view = UIImageView()
        view.image = Service.generateQRCode()
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
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = Color.mainRedColor
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        
        return button
    }()
    
    @objc func tap() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = Color.mainTextColor
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.mainTextColor!]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = Color.mainTextColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = Color.mainBackgroundColor
        
        view.addSubview(logo)
        view.addSubview(phForQRCode)
        
        phForQRCode.addSubview(qrCode)
        phForQRCode.addSubview(textForQRCode)
        
        view.addSubview(button)
        
        logo.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
            make.centerX.equalTo(phForQRCode)
            make.top.equalTo(phForQRCode).inset(view.frame.height / 15)
            make.left.right.equalTo(phForQRCode).inset(50)
//            make.height.equalTo(view.frame.height / 3)
//            make.width.equalTo(view.frame.width / 1.4)
            make.bottom.equalTo(phForQRCode).inset(view.frame.height / 5.5)
        }
        
        textForQRCode.snp.makeConstraints { make in
//            make.top.equalTo(qrCode.snp.bottom)
            make.left.right.equalTo(phForQRCode)
            make.height.equalTo(70)
            make.bottom.equalTo(phForQRCode).inset(25)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
}
