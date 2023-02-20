//
//  ProfileSettingViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit
import PhotosUI
import IQKeyboardManager
import SkeletonView
import TextFieldEffects

class ProfileSettingViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isUserInteractionEnabled = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var contentView: UIStackView = {
        let content = UIStackView()
        content.axis = .vertical
        content.isUserInteractionEnabled = true
        content.spacing = 30
        content.addArrangedSubview(borderForPhoto)
        borderForPhoto.addSubview(photoImageView)
        content.addArrangedSubview(nameText)
        content.addArrangedSubview(nameTextField)
        content.addArrangedSubview(numberText)
        content.addArrangedSubview(numberTextField)
        content.addArrangedSubview(loginText)
        content.addArrangedSubview(loginTextField)
        content.addArrangedSubview(birthdayText)
        content.addArrangedSubview(birthdayTextField)
        content.addArrangedSubview(saveButton)
        content.addArrangedSubview(deleteAccountButton)
        return content
    }()
    
    private let borderForPhoto: UIView = {
        let border = UIView()
        border.backgroundColor = Color.mainBackgroundColor
        border.clipsToBounds = true
        border.layer.borderWidth = 1
        border.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        border.layer.cornerRadius = 75
        return border
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 73
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Service.downloadImages(photo: imageView)
        imageView.addGestureRecognizer(gestureForPhoto)
        imageView.isUserInteractionEnabled = true
        return imageView
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
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let nameTextField: UITextField = {
        let textField = IsaoTextField()
        Service.getName { name in
            textField.text = name
        }
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.tintColor = Color.mainTextColor
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
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let numberTextField: UITextField = {
        let textField = IsaoTextField()
        Service.getPhone { phone in
            textField.text = phone
        }
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.tintColor = Color.mainTextColor
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
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let loginTextField: UITextField = {
        let textField = IsaoTextField()
        Service.getEmail { email in
            textField.text = email
        }
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.tintColor = Color.mainTextColor
        textField.activeColor = .systemRed
        textField.inactiveColor = .systemGray5
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textField.returnKeyType = .done
        return textField
    }()
    
    private let birthdayText: UILabel = {
        let text = UILabel()
        text.text = "Дата рождения"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let birthdayTextField: UITextField = {
        let textField = IsaoTextField()
        Service.getBirthday { birthday in
            textField.text = birthday
        }
        textField.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        textField.placeholderFontScale = CGFloat(0.8)
        textField.tintColor = Color.mainTextColor
        textField.activeColor = .systemRed
        textField.inactiveColor = .systemGray5
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textField.textContentType = .dateTime
        return textField
    }()
    
    private lazy var backToLoginView: UILabel = {
        let text = UILabel()
        text.text = "Логин"
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
    
    private lazy var deleteAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить Аккаунт", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainBackgroundColor
        button.layer.borderWidth = 1
        button.layer.borderColor = Color.mainTextColor?.cgColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(Save), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupView()
        
    }
    
    private func setupView() {
        
        loginTextField.delegate = self
        birthdayTextField.delegate = self
        
        title = "Редактировать профиль"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = Color.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Color.mainTextColor!]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = Color.mainBackgroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.left.right.equalTo(scrollView).inset(15)
            make.centerX.equalTo(scrollView)
            make.bottom.equalTo(scrollView).inset(40)
        }
        
        borderForPhoto.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.height.equalTo(150)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.center.equalTo(borderForPhoto)
            make.height.equalTo(146)
            make.size.equalTo(146)
        }
        
        deleteAccountButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        saveButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
}

//MARK: - UITextFieldDelegate

extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

//MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension ProfileSettingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = image
        }
    }
}

//MARK: - Function's

extension ProfileSettingViewController {
    
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
    
    private func deleteAlert() {
        let alert = UIAlertController(title: "Вы уверены?", message: "Вы желаете удалить аккаунт?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .destructive))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func Save(_ sender: UIButton) {
        animateView(sender)
        Service.updateUserDataToFSFromUP(name: nameTextField.text!, phone: numberTextField.text!, login: loginTextField.text!, image: photoImageView, birthday: birthdayTextField.text ?? "")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteAccount(_ sender: UIButton) {
        animateView(sender)
        presentSimpleAlert(title: "Удалить аккаунт", message: "Вы уверены, что хотите удалить акканут?")
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

import FirebaseAuth

extension ProfileSettingViewController {
    
    func presentSimpleAlert(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
        let okAction = UIAlertAction(title: "Да", style: .destructive) { _ in
            
            do {
                Service.deleteAccount()
            }
        }
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}


