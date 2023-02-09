//
//  LoginViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit
import IQKeyboardManager
import TextFieldEffects

class LoginViewController: UIViewController {
    
    private let largeText: UILabel = {
        let text = UILabel()
        text.text = "Войдите, чтобы \nкопить баллы и \nполучать \nподарки!"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 35)
        text.textAlignment = .center
        text.numberOfLines = 0
        text.textColor = .black
        return text
    }()
    
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleToFill
        return logo
    }()
    
    private let loginText: UILabel = {
        let text = UILabel()
        text.text = "Логин"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = .black
        return text
    }()
    
    private let loginTextField: UITextField = {
        let textField = IsaoTextField()
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.tintColor = .black
        textField.activeColor = .systemRed
        textField.inactiveColor = .systemGray2
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textField.returnKeyType = .done
        return textField
    }()
    
    private let passwordText: UILabel = {
        let text = UILabel()
        text.text = "Пароль"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = .black
        return text
    }()
    
    private let passwordTextField: UITextField = {
        let textField = IsaoTextField()
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.tintColor = .black
        textField.activeColor = .systemRed
        textField.inactiveColor = .systemGray2
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var goToRegisterView: UILabel = {
        let text = UILabel()
        text.text = "Регистрация"
        text.textAlignment = .center
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textColor = .black
        text.addGestureRecognizer(gestureForText)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var gestureForText: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapText))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Логин", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(Login), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupView()
        
    }
    
    private func setupView() {
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.backgroundColor = .white
        view.addSubview(logo)
        view.addSubview(largeText)
        view.addSubview(loginText)
        view.addSubview(loginTextField)
        view.addSubview(passwordText)
        view.addSubview(passwordTextField)
        view.addSubview(goToRegisterView)
        view.addSubview(sendButton)
        
        logo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        
        largeText.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(170)
        }
        
        loginText.snp.makeConstraints { make in
            make.top.equalTo(largeText.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(loginText.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        passwordText.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordText.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        goToRegisterView.snp.makeConstraints { make in
            make.left.right.equalTo(sendButton)
            make.height.equalTo(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(25)
        }
        
        sendButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

//MARK: - Function's

extension LoginViewController {
    
    private func showAlert2() {
        let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста проверьте правильность вводимых данныых", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func Login(_ sender: UIButton) {
        
        Service.Login(login: loginTextField.text!, password: passwordTextField.text!) {
        } onError: { error in
            self.showAlert2()
        }
        animateView(sender)
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
    
    @objc private func tapText(_ gesture: UITapGestureRecognizer) {
        let scene = RegisterViewController()
        navigationController?.pushViewController(scene, animated: false)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
