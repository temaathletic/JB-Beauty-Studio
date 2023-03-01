//
//  SettiingSaleBoxViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 13.02.2023.
//

import UIKit
import SnapKit
import PhotosUI

class SettingSaleBoxViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var picker1 : UIImagePickerController?
    var picker2 : UIImagePickerController?
    var picker3 : UIImagePickerController?
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
    
    private let scrollview2: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.bounces = true
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    private lazy var contentView2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    private lazy var photoImageView1: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "placeholderBox1")
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var photoImageView2: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "placeholderBox2")
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var photoImageView3: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "placeholderBox3")
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var photoImageView1_2: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var photoImageView1_3: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let labelText: UILabel = {
        let text = UILabel()
        text.text = "Активировать меню акций"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private let labelSaleText: UILabel = {
        let text = UILabel()
        text.text = "Установите изображения для акций"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        text.textColor = Color.mainTextColor
        text.numberOfLines = 0
        text.textAlignment = .center
        return text
    }()
    
    private let labelSaleSettingText: UILabel = {
        let text = UILabel()
        text.text = "Установите изображения акции 1 и фон"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        text.textColor = Color.mainTextColor
        text.numberOfLines = 0
        text.textAlignment = .center
        return text
    }()
    
    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switchValueDidChange), for: .touchUpInside)
        return switcher
    }()
    
    private lazy var settingSaleBox2: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить акцию 2", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(settingSaleBox2Action), for: .touchUpInside)
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
        
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
                
        [photoImageView1,photoImageView2,photoImageView3,photoImageView1_2,photoImageView1_3].forEach {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
        }
        
        view.backgroundColor = Color.mainBackgroundColor
        
        view.addSubview(switcher)
        view.addSubview(labelText)
        view.addSubview(scrollview)
        view.addSubview(labelSaleText)
        view.addSubview(labelSaleSettingText)
        scrollview.addSubview(contentView)
        contentView.addArrangedSubview(photoImageView1)
        contentView.addArrangedSubview(photoImageView2)
        contentView.addArrangedSubview(photoImageView3)
        view.addSubview(scrollview2)
        scrollview2.addSubview(contentView2)
        contentView2.addArrangedSubview(photoImageView1_2)
        contentView2.addArrangedSubview(photoImageView1_3)
        view.addSubview(settingSaleBox2)
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
        
        photoImageView1.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalTo(180)
            make.width.equalTo(view.frame.width / 1.1)
        }

        photoImageView2.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalTo(180)
            make.width.equalTo(view.frame.width / 1.1)
        }

        photoImageView3.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalTo(180)
            make.width.equalTo(view.frame.width / 1.1)
        }
        
        labelSaleSettingText.snp.makeConstraints { make in
            make.top.equalTo(scrollview.snp.bottom).inset(-20)
            make.left.right.equalToSuperview()
        }
        
        scrollview2.snp.makeConstraints { make in
            make.top.equalTo(labelSaleSettingText.snp.bottom).inset(-20)
            make.left.right.equalTo(view)
            make.height.equalTo(200)
        }

        contentView2.snp.makeConstraints { make in
            make.left.right.equalTo(scrollview2).inset(20)
            make.centerY.equalTo(scrollview2)
        }

        photoImageView1_2.snp.makeConstraints { make in
            make.centerY.equalTo(contentView2)
            make.height.equalTo(180)
            make.width.equalTo(view.frame.width / 1.1)
        }

        photoImageView1_3.snp.makeConstraints { make in
            make.centerY.equalTo(contentView2)
            make.height.equalTo(180)
            make.width.equalTo(view.frame.width / 1.1)
        }

        labelText.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.bottom.equalTo(saveButton.snp.top).inset(-30)
        }
        
        settingSaleBox2.snp.makeConstraints { make in
            make.bottom.equalTo(switcher.snp.top).inset(-20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        switcher.snp.makeConstraints { make in
            make.centerY.equalTo(labelText)
            make.right.equalTo(view).inset(20)
        }

        saveButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func switchValueDidChange(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadSaleBoxStatus(true)
        }
        else{
            print("off")
            Service.uploadSaleBoxStatus(false)
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
    
    @objc func settingSaleBox2Action() {
        let vc = SettingSaleBox2ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func Save() {
        Service.uploadImageForSaleBox(photoImageView1, name: "SaleBox1")
        Service.uploadImageForSaleBox(photoImageView2, name: "SaleBox2")
        Service.uploadImageForSaleBox(photoImageView3, name: "SaleBox3")
        Service.uploadImageForSaleBox(photoImageView1_2, name: "SaleBox1MainPic")
        Service.uploadImageForSaleBox(photoImageView1_3, name: "SaleBox1MainBack")
        dismiss(animated: true)
    }
}
