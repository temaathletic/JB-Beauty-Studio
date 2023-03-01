//
//  LoginViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit
import IQKeyboardManager

class LoginViewController: UIViewController {
    
    private let loginTextField1 = CustomTextField(placeholderText: "", image: "envelope", name: "Логин", isSecure: false)
    private let registerTextField = CustomTextField(placeholderText: "", image: "lock", name: "Пароль", isSecure: true)
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = true
        return scroll
    }()
    
    private lazy var content: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.addArrangedSubview(logoAndTextStackView)
        stack.addArrangedSubview(loginTextField1)
        stack.addArrangedSubview(registerTextField)
        stack.addArrangedSubview(sendButton)
        stack.addArrangedSubview(registerSkipRegisterStackView)
        stack.addArrangedSubview(forgotPasswordStackView)
        return stack
    }()
    
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.clipsToBounds = true
        logo.contentMode = .scaleAspectFit
        return logo
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
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Логин", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainBackgroundColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(Login), for: .touchUpInside)
        return button
    }()
    
    private lazy var register: UILabel = {
        let text = UILabel()
        text.text = "Регистрация"
        text.textAlignment = .right
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textColor = Color.mainTextColor
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
    
    private lazy var skipRegister: UILabel = {
        let text = UILabel()
        text.text = "Пропустить"
        text.textAlignment = .left
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textColor = Color.mainTextColor
        text.addGestureRecognizer(skipReegisterAction)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var registerSkipRegisterStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .horizontal
        stack.addArrangedSubview(register)
        stack.addArrangedSubview(slash)
        stack.addArrangedSubview(skipRegister)
        
        register.snp.makeConstraints { make in
            make.right.equalTo(slash.snp.left).inset(-10)
        }
        
        slash.snp.makeConstraints { make in
            make.centerX.equalTo(stack)
        }
        
        skipRegister.snp.makeConstraints { make in
            make.left.equalTo(slash.snp.right).inset(-10)
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
    
    private lazy var forgotPasswordStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.addArrangedSubview(forgotPassword)
        return stack
    }()
    
    private lazy var gestureForText: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapText))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var skipReegisterAction: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(skipAction))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var forgotPasswordAction: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(recoveryPasswordAction))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupAddTargetIsNotEmptyTextFields()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - SetupView
    
    private func setupView() {
        
        loginTextField1.delegate = self
        registerTextField.delegate = self
        
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
            make.left.right.equalTo(scrollView).inset(30)
        }
        
        logo.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        loginTextField1.snp.makeConstraints { make in
            make.left.right.equalTo(content)
        }
        
        registerTextField.snp.makeConstraints { make in
            make.left.right.equalTo(content)
        }
        
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
    
    private func setupAddTargetIsNotEmptyTextFields() {
        sendButton.isEnabled = false
        UIView.transition(with: sendButton, duration: 0.6, options: .curveEaseInOut, animations: {
            self.sendButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.1098039216, alpha: 0.2)
        })
        loginTextField1.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                  for: .editingChanged)
        registerTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                    for: .editingChanged)
    }
    
    @objc private func textFieldsIsNotEmpty(sender: UITextField) {
        
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            let login = loginTextField1.text, !login.isEmpty,
            let password = registerTextField.text, !password.isEmpty
        else {
            
            UIView.transition(with: sendButton, duration: 0.6, options: .curveEaseInOut, animations: {
                self.sendButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.1098039216, alpha: 0.2)
            })
            self.sendButton.isEnabled = false
            return }
        
        UIView.transition(with: sendButton, duration: 0.5, options: .curveEaseInOut, animations: {
            self.sendButton.backgroundColor = Color.mainRedColor
            self.sendButton.isEnabled = true
            self.sendButton.layer.shadowColor = Color.mainRedColor?.cgColor
            self.sendButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.sendButton.layer.shadowRadius = 10
            self.sendButton.layer.shadowOpacity = 0.5
        })
    }
    
    @objc private func recoveryPasswordAction() {
        navigationController?.pushViewController(ResetPasswordViewController(), animated: true)
    }
    
    @objc private func skipAction() {
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
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
        
        Service.Login(login: loginTextField1.text!, password: registerTextField.text!) {
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
    
    @objc private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
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
