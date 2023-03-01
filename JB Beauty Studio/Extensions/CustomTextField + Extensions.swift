//
//  CustomTextField + Extensions.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 01.03.2023.
//

import UIKit
import SnapKit

final class CustomTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    private let icon = UIImageView()
    private let nameLabel = UILabel()
    private let ph = UIView()
    
    init(placeholderText: String, image: String, name: String, isSecure: Bool) {
        super.init(frame: .zero)
        
        setupTextField(placeholderText: placeholderText, image: image, name: name, isSecureType: isSecure)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func setupTextField(placeholderText: String, image: String, name: String, isSecureType: Bool) {
        
        addSubview(ph)
        ph.addSubview(nameLabel)
        addSubview(icon)
        
        isSecureTextEntry = isSecureType
        autocapitalizationType = .none
        nameLabel.text = name
        nameLabel.font = UIFont(name: "GlacialIndifference-Regular", size: 13)
        nameLabel.textColor = Color.mainTextColor
        nameLabel.textAlignment = .center
        
//        let attributes = [
//            NSAttributedString.Key.foregroundColor: Color.mainTextColorWithOppacity!,
//            NSAttributedString.Key.font : UIFont(name: "GlacialIndifference-Regular", size: 12)!
//        ]
//
//        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            .foregroundColor: Color.mainTextColorWithOppacity!,
            .font: UIFont(name: "GlacialIndifference-Regular", size: 12)!
        ])
        
        icon.image = UIImage(systemName: image)
        icon.contentMode = .scaleAspectFit
        icon.tintColor = Color.mainTextColor
        
        textColor = Color.mainTextColor
        font = UIFont(name: "GlacialIndifference-Regualr", size: 18)
        
        layer.backgroundColor = Color.mainBackgroundColor?.cgColor
        borderStyle = .roundedRect
        backgroundColor = .clear
        layer.borderColor = UIColor.black.cgColor
        layer.allowsEdgeAntialiasing = true
        ph.backgroundColor = Color.mainBackgroundColor
        
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(ph)
        }
        
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        ph.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-8)
            make.left.equalToSuperview().inset(28)
            make.width.equalTo(nameLabel)
            make.height.equalTo(19)
        }
    }
}
