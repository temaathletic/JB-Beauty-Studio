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
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = true
        return scroll
    }()
    
    private let loginTextField1 = CustomTextField(placeholder: "Enter login")
    private let registerTextField = CustomTextField(placeholder: "Enter password")
    
    private lazy var content: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.addArrangedSubview(logoAndTextStackView)
//        stack.addArrangedSubview(loginText)
//        stack.addArrangedSubview(loginTextField1)
//        stack.addArrangedSubview(passwordText)
//        stack.addArrangedSubview(registerTextField)
        stack.addArrangedSubview(loginStackView)
        stack.addArrangedSubview(passwordStackView)
        stack.addArrangedSubview(sendButton)
        stack.addArrangedSubview(registerSkipRegisterStackView)
        stack.addArrangedSubview(forgotPasswordStackView)
        return stack
    }()
    
    private let largeText: UILabel = {
        let text = UILabel()
        text.text = "Войдите, чтобы \nкопить баллы и \nполучать \nподарки!"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        text.textAlignment = .center
        text.numberOfLines = 0
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.clipsToBounds = true
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private lazy var logoAndTextStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 18
        stack.axis = .vertical
        stack.addArrangedSubview(logo)
        stack.addArrangedSubview(largeText)
        return stack
    }()
    
    private let loginText: UILabel = {
        let text = UILabel()
        text.text = "Логин"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let loginTextField: UITextField = {
        let textField = IsaoTextField()
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.activeColor = .systemRed
        textField.inactiveColor = .systemGray5
        textField.textColor = Color.mainTextColor
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.axis = .vertical
        
        stack.addArrangedSubview(loginText)
        stack.addArrangedSubview(loginTextField)
        return stack
    }()
    
    private let passwordText: UILabel = {
        let text = UILabel()
        text.text = "Пароль"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let passwordTextField: UITextField = {
        let textField = IsaoTextField()
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.activeColor = .systemRed
        textField.inactiveColor = .systemGray5
        textField.textColor = Color.mainTextColor
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.axis = .vertical
        stack.addArrangedSubview(passwordText)
        stack.addArrangedSubview(passwordTextField)
        return stack
    }()
    
    private lazy var register: UILabel = {
        let text = UILabel()
        text.text = "Регистрация"
        text.textAlignment = .center
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textColor = Color.mainTextColor
        text.backgroundColor = Color.mainBackgroundColor
        text.layer.cornerRadius = 10
        text.addGestureRecognizer(gestureForText)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var slash: UILabel = {
        let text = UILabel()
        text.text = "/"
        text.textAlignment = .center
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textColor = Color.mainTextColor
        text.backgroundColor = Color.mainBackgroundColor
        text.layer.cornerRadius = 10
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
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 20
        button.layer.shadowColor = Color.mainRedColor?.cgColor
        button.layer.shadowOpacity = 0.6
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.addTarget(self, action: #selector(Login), for: .touchUpInside)
        return button
    }()
    
    private let sendImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "rectangle.portrait.and.arrow.forward")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var skipRegister: UILabel = {
        let text = UILabel()
        text.text = "Пропустить"
        text.textAlignment = .center
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textColor = Color.mainTextColor
        text.backgroundColor = Color.mainBackgroundColor
        text.layer.cornerRadius = 10
        text.addGestureRecognizer(skipReegisterAction)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var skipReegisterAction: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(skipAction))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var registerSkipRegisterStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 3
        stack.axis = .horizontal
        stack.addArrangedSubview(register)
        stack.addArrangedSubview(slash)
        stack.addArrangedSubview(skipRegister)
        
        register.snp.makeConstraints { make in
            make.right.equalTo(slash.snp.left).inset(-3)
        }
        
        slash.snp.makeConstraints { make in
            make.centerX.equalTo(stack)
        }
        
        skipRegister.snp.makeConstraints { make in
            make.left.equalTo(slash.snp.right).inset(-3)
        }
        return stack
    }()
    
    private lazy var forgotPassword: UILabel = {
        let text = UILabel()
        text.text = "Забыли в пароль?"
        text.textAlignment = .center
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textColor = Color.mainTextColor
        text.backgroundColor = Color.mainBackgroundColor
        text.layer.cornerRadius = 10
        text.addGestureRecognizer(forgotPasswordAction)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var forgotPasswordAction: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(recoveryPasswordAction))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var forgotPasswordStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.addArrangedSubview(forgotPassword)
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        view.backgroundColor = Color.mainBackgroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(content)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(-20)
            make.left.right.bottom.equalToSuperview()
        }

        content.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.centerX.equalToSuperview()
            make.left.right.equalTo(scrollView).inset(20)
        }

        logo.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
//        loginTextField1.snp.makeConstraints { make in
//            make.left.right.equalTo(content)
//        }
//
//        registerTextField.snp.makeConstraints { make in
//            make.left.right.equalTo(content)
//        }
//
//        register.snp.makeConstraints { make in
//            make.height.equalTo(40)
//        }
//
//        skipRegister.snp.makeConstraints { make in
//            make.height.equalTo(40)
//        }
//
        sendButton.snp.makeConstraints { make in
            make.height.equalTo(60)
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
    
    @objc func recoveryPasswordAction() {
        navigationController?.pushViewController(ResetPasswordViewController(), animated: true)
    }
    
    @objc func skipAction() {
        navigationController?.pushViewController(MainViewController(), animated: true)
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
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct LoginVC: PreviewProvider {
    
    static var previews: some View {
        LoginViewController().toPreview()
    }
}
#endif
