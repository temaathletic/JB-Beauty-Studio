//
//  UserChangeBonus.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 06.01.2023.
//

import UIKit
import SnapKit

class UserChangeBonus: UIViewController {
    
    public var stringValue3 = ""
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Введите новые баллы"
        label.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        label.textColor = Color.mainTextColor
        label.textAlignment = .center
        return label
    }()
    
    static let bonusTextField: UITextField = {
        let textF = UITextField()
        textF.textColor = Color.mainTextColor
        textF.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        textF.layer.cornerRadius = 15
        textF.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textF.layer.borderWidth = 1
        textF.leftViewMode = .always
        textF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textF.keyboardType = .numberPad
        return textF
    }()
    
    private lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Сохранить", for: .normal)
        btn.setTitleColor(Color.mainTextColor, for: .normal)
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .systemRed
        btn.addTarget(self, action: #selector(saveBonus), for: .touchUpInside)
        return btn
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = Color.mainBackgroundColor
        view.addSubview(saveBtn)
        view.addSubview(UserChangeBonus.bonusTextField)
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalTo(UserChangeBonus.bonusTextField.snp.top).inset(-20)
        }
        
        UserChangeBonus.bonusTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.top.equalTo(UserChangeBonus.bonusTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(90)
            make.height.equalTo(60)
        }
    }
}

extension UserChangeBonus {
    
    @objc func saveBonus() {
        animateView(saveBtn)
        Service.editBonusPoint(Int(UserChangeBonus.bonusTextField.text!)!, UID: stringValue3)
        Service.afterBlock(seconds: 1, queue: .main) {
            self.dismiss(animated: true)
        }
        navigationController?.popViewController(animated: true)
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


