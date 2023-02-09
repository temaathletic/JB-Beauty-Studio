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
        button.setTitle("Другая опция", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("Другая опция", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return button
    }()
    
    private lazy var startScan: UIButton = {
        let button = UIButton()
        button.setTitle("Сканировать QR", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.addTarget(self, action: #selector(startScann), for: .touchUpInside)
        return button
    }()
    
    @objc private func startScann() {
        modalPresentationStyle = .popover
        present(ScanViewController(), animated: true)
    }
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выход", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.addTarget(self, action: #selector(tapExit), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapExit() {
        presentSimpleAlert(title: "Выход", message: "Вы уверены, что хотите выйти из акканута")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(exitButton)
        view.addSubview(startScan)
        
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
        
        startScan.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
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
