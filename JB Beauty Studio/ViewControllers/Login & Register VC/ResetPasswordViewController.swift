//
//  ResetPasswordViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 25.02.2023.
//

import UIKit
import SnapKit
import TextFieldEffects
import Firebase

class ResetPasswordViewController: UIViewController {
    
    private lazy var resetText: UILabel = {
        let text = UILabel()
        text.text = "Введите почту"
        text.textAlignment = .center
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 23)
        text.textColor = Color.mainTextColor
        text.backgroundColor = Color.mainBackgroundColor
        text.layer.cornerRadius = 10
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private let loginText: UILabel = {
        let text = UILabel()
        text.text = "Логин"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let loginTextField: UITextView = {
        let textField = UITextView()
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.textColor = Color.mainTextColor
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = Color.mainBackgroundColor
        view.addSubview(resetText)
        view.addSubview(loginTextField)
        view.addSubview(sendButton)
        
        resetText.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(15)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(resetText.snp.bottom).inset(-20)
            make.height.equalTo(60)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).inset(-20)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(60)
        }
    }
    
    @objc private func sendEmail() {
        
        animateView(sendButton)
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: loginTextField.text!) { (error) in
            if let error = error {
                let errorAlert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true)
                return
            }
            
            let alert = UIAlertController(title: "Отлично", message: "На вашу почту было отправлено письмо с ссылкой на восстановление пароля", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "На главный экран", style: .default) {
                UIAlertAction in
                self.navigationController?.popViewController(animated: true)
             }
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    @objc private func animateView(_ viewAnimate: UIView) {
        UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations:  {
            viewAnimate.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.4, options: .curveEaseIn) {
                viewAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
