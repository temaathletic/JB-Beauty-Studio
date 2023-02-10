//
//  TechnichalSupportViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit

class TechnichalSupportViewController: UIViewController {
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private let email: UILabel = {
        let email = UILabel()
        email.text = "Email"
        email.font = UIFont(name: "GlacialIndifference-Regular", size: 25)
        email.textAlignment = .left
        email.textColor = Color.mainTextColor
        return email
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 0.8043929346)
        textField.attributedPlaceholder = NSAttributedString(string: "Email")
        textField.tintColor = Color.mainTextColor
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.6971066709)
        textField.layer.borderWidth = 1
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        return textField
    }()
    
    private let reportProblem: UILabel = {
        let text = UILabel()
        text.text = "Опишите проблему"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 25)
        text.textAlignment = .left
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let reportTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 0.8043929346)
        textField.attributedPlaceholder = NSAttributedString(string: "Опишите проблему")
        textField.tintColor = Color.mainTextColor
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.6971066709)
        textField.layer.borderWidth = 1
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Техническая поддержка"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = Color.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Color.mainTextColor!]
        
        view.backgroundColor = Color.mainBackgroundColor
        
        view.addSubview(logo)
        view.addSubview(email)
        view.addSubview(emailTextField)
        view.addSubview(reportProblem)
        view.addSubview(reportTextField)
        view.addSubview(sendButton)
        
        sendButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(40)
        }
        
        reportProblem.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        reportTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(reportProblem.snp.bottom).offset(15)
            make.height.equalTo(120)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(email.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        email.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        logo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
    }
}
