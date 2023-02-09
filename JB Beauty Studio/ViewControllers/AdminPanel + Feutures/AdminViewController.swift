//
//  AdminViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class AdminViewController: UIViewController {
    
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("Найти человека", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(searchPeople), for: .touchUpInside)
        return button
    }()
    
    private let personImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("Списать баллы QR", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(decrimentBonus), for: .touchUpInside)
        return button
    }()
    
    private let qrCodeImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "qrcode.viewfinder")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var startScan: UIButton = {
        let button = UIButton()
        button.setTitle("Сканировать QR", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(startScann), for: .touchUpInside)
        return button
    }()
    
    private let qrCodeImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "qrcode.viewfinder")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    @objc private func startScann() {
        modalPresentationStyle = .popover
        present(ScanViewController(), animated: true)
    }
    
    @objc private func searchPeople() {
        let vc = SearchPeopleViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    @objc private func decrimentBonus() {
        let vc = ScanVCFormCartForDicrement()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выход", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapExit), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapExit() {
        presentSimpleAlert(title: "Выход", message: "Вы уверены, что хотите выйти из акканута")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.mainBackgroundColor
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(exitButton)
        view.addSubview(startScan)
        startScan.addSubview(qrCodeImage1)
        button2.addSubview(qrCodeImage2)
        button1.addSubview(personImage)
        
        button2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.top.equalTo(startScan.snp.bottom).inset(-10)
        }
        
        button1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.bottom.equalTo(startScan.snp.top).inset(-10)
        }
        
        personImage.snp.makeConstraints { make in
            make.right.equalTo(button1).inset(15)
            make.centerY.equalTo(button1)
            make.size.equalTo(30)
        }
        
        startScan.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        qrCodeImage1.snp.makeConstraints { make in
            make.right.equalTo(startScan).inset(15)
            make.centerY.equalTo(startScan)
            make.size.equalTo(30)
        }
        
        qrCodeImage2.snp.makeConstraints { make in
            make.right.equalTo(button2).inset(15)
            make.centerY.equalTo(button2)
            make.size.equalTo(30)
        }
        
        exitButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}

extension AdminViewController {

    func presentSimpleAlert(title: String, message: String?) {

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in

            do {
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}
