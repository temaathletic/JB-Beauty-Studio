//
//  RegisterViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 03.01.2023.
//

import UIKit
import SnapKit
import PhotosUI
import IQKeyboardManager
import TextFieldEffects

class RegisterViewController: UIViewController {
    
    private let borderForPhoto: UIView = {
        let border = UIView()
        border.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        border.layer.borderWidth = 1
        border.layer.cornerRadius = 75
        return border
    }()
    
    private lazy var photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(named: "smile")
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 73
        photo.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        photo.layer.borderWidth = 1
        photo.contentMode = .scaleAspectFill
        photo.addGestureRecognizer(gestureForPhoto)
        photo.isUserInteractionEnabled = true
        return photo
    }()
    
    private let plusSticker: UIImageView = {
        let sticker = UIImageView()
        sticker.image = UIImage(systemName: "plus.circle.fill")
        sticker.contentMode = .scaleAspectFill
        sticker.tintColor = .red
        return sticker
    }()
    
    private lazy var gestureForPhoto: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPhoto))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private let nameText: UILabel = {
        let text = UILabel()
        text.text = "Имя"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = .black
        return text
    }()
    
    private let nameTextField: UITextField = {
        let textField = IsaoTextField()
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.tintColor = .black
        textField.activeColor = .systemRed
        textField.inactiveColor = .systemGray5
        textField.layer.cornerRadius = 15
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        return textField
    }()
    
    private let numberText: UILabel = {
        let text = UILabel()
        text.text = "Телефон"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = .black
        return text
    }()
    
    private let numberTextField: UITextField = {
        let textField = IsaoTextField()
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.tintColor = .black
        textField.activeColor = .systemRed
        textField.inactiveColor = .systemGray5
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .numberPad
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        return textField
    }()
    
    private let loginText: UILabel = {
        let text = UILabel()
        text.text = "Электронная почта"
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
        textField.inactiveColor = .systemGray5
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
        textField.inactiveColor = .systemGray5
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.textContentType = .newPassword
        return textField
    }()
    
    private lazy var backToLoginView: UILabel = {
        let text = UILabel()
        text.text = "Логин"
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
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(Register), for: .touchUpInside)
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
        
        view.addSubview(borderForPhoto)
        borderForPhoto.addSubview(photoImageView)
        view.addSubview(plusSticker)
        view.addSubview(nameText)
        view.addSubview(nameTextField)
        view.addSubview(numberText)
        view.addSubview(numberTextField)
        view.addSubview(loginText)
        view.addSubview(loginTextField)
        view.addSubview(passwordText)
        view.addSubview(passwordTextField)
        view.addSubview(backToLoginView)
        view.addSubview(sendButton)
        
        borderForPhoto.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.center.equalTo(borderForPhoto)
            make.size.equalTo(146)
        }
        
        plusSticker.snp.makeConstraints { make in
            make.top.right.equalTo(photoImageView).inset(10)
            make.height.equalTo(45)
        }
        
        nameText.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameText.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        numberText.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(numberText.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        loginText.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(loginText.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        passwordText.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordText.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        backToLoginView.snp.makeConstraints { make in
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

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

//MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = image
        }
    }
}

//MARK: - Function's

extension RegisterViewController {
    
    @objc private func tapPhoto(_ gesture: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
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
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func tapText(_ gesture: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: false)
    }
    
    private func showAlert2() {
        let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста проверьте правильность вводимых данныых", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func Register(_ sender: UIButton) {
        
        Service.uploadUserDataToFS(name: nameTextField.text!, phone: numberTextField.text!, login: loginTextField.text!, password: passwordTextField.text!)
        Service.Register(login: loginTextField.text!, phone: numberTextField.text!, password: passwordTextField.text!, name: nameTextField.text!, image: photoImageView) {
        } onError: { error in
            self.showAlert2()
        }
        animateView(sender)
    }
    
    private func animateView(_ viewAnimate: UIView) {
        UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations:  {
            viewAnimate.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.4, options: .curveEaseIn) {
                viewAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}

