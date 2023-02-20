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
    
    private lazy var content: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        
        stack.addArrangedSubview(largeText)
        stack.addArrangedSubview(loginText)
        stack.addArrangedSubview(loginTextField)
        stack.addArrangedSubview(passwordText)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(sendButton)
        stack.addArrangedSubview(goToRegisterView)
        stack.addArrangedSubview(skipRegister)
        return stack
    }()
    
    private let largeText: UILabel = {
        let text = UILabel()
        text.text = "Войдите, чтобы \nкопить баллы и \nполучать \nподарки!"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 30)
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
    
    private lazy var goToRegisterView: UILabel = {
        let text = UILabel()
        text.text = "Регистрация"
        text.textAlignment = .center
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textColor = Color.mainTextColor
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
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(Login), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipRegister: UILabel = {
        let text = UILabel()
        text.text = "Пропустить регистрацию"
        text.textAlignment = .center
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.textColor = Color.mainTextColor
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        view.backgroundColor = Color.mainBackgroundColor
        view.addSubview(logo)
        view.addSubview(scrollView)
        scrollView.addSubview(content)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).inset(-30)
            make.left.right.bottom.equalToSuperview()
        }
        
        logo.snp.makeConstraints { make in
            make.size.equalTo(150)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        content.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.left.right.equalTo(scrollView).inset(20)
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
