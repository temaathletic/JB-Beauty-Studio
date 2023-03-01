//
//  SettingSaleBox2ViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 25.02.2023.
//

import UIKit
import SnapKit
import PhotosUI
import TextFieldEffects

class SettingSaleBox2ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var picker1 : UIImagePickerController?
    var imagePicker = UIImagePickerController()
    var selectedVew: UIView!
    
    private let scrollview: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.bounces = true
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    private lazy var contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let text = UILabel()
        text.text = "Заголовок"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let textViewLabel: UILabel = {
        let text = UILabel()
        text.text = "Введите текст для акции"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = Color.mainTextColor
        return text
    }()
    
    private let textView: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.layer.borderColor = UIColor.systemGray3.cgColor
        text.layer.borderWidth = 1
        return text
    }()
    
    private let titleTextField: UITextField = {
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
    
    private lazy var photoImageView2_1: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let labelSaleText: UILabel = {
        let text = UILabel()
        text.text = "Установите изображения для акции 2"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        text.textColor = Color.mainTextColor
        text.numberOfLines = 0
        text.textAlignment = .center
        return text
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
        
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
                
        [photoImageView2_1].forEach {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
        }
        
        view.backgroundColor = Color.mainBackgroundColor
        
        view.addSubview(scrollview)
        view.addSubview(labelSaleText)
        scrollview.addSubview(contentView)
        contentView.addArrangedSubview(photoImageView2_1)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(textViewLabel)
        view.addSubview(textView)
        view.addSubview(saveButton)
        
        labelSaleText.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.left.right.equalToSuperview()
        }
        
        scrollview.snp.makeConstraints { make in
            make.top.equalTo(labelSaleText.snp.bottom).inset(-20)
            make.left.right.equalTo(view)
            make.height.equalTo(200)
        }
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalTo(scrollview).inset(20)
            make.centerY.equalTo(scrollview)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        textViewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(textViewLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(saveButton.snp.top).inset(-10)
        }
        
        photoImageView2_1.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalTo(180)
            make.width.equalTo(view.frame.width / 1.1)
        }

        saveButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc func chooseImage(_ gesture: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            selectedVew = gesture.view
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        (selectedVew as? UIImageView)?.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @objc func Save() {
        Service.uploadImageForSaleBox(photoImageView2_1, name: "SaleBox2_1")
        Service.uploadTextForSaleBox2(textView.text!, titleTextField.text!)
        dismiss(animated: true)
    }
}

