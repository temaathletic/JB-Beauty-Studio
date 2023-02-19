//
//  UserIncrementBonus.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 12.02.2023.
//

import UIKit
import SnapKit
import Lottie

class UserIncrementBonus: UIViewController {
    
    public var uidFromScaner = ""
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Введите баллы для пополненния"
        label.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        label.textColor = Color.mainTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    public let bonusTextField: UITextField = {
        let textF = UITextField()
        textF.textColor = Color.mainTextColor
        textF.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        textF.layer.cornerRadius = 15
        textF.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textF.layer.borderWidth = 1
        textF.leftViewMode = .always
        textF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
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
        view.addSubview(bonusTextField)
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalTo(bonusTextField.snp.top).inset(-20)
        }
        
        bonusTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.top.equalTo(bonusTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(90)
            make.height.equalTo(60)
        }
    }
}

extension UserIncrementBonus {
    
    @objc func saveBonus() {
        animateView(saveBtn)
        Service.getBonusPointForDecriment(self.uidFromScaner) { bonusPoint in
            let bonusFromFB = bonusPoint ?? 0
            let textFromTF = self.bonusTextField.text!
            let bonusInt = Int(textFromTF) ?? 0
            let newBonus = bonusInt + bonusFromFB
            print(bonusFromFB)
            print(textFromTF)
            print(bonusInt)
            print(newBonus)
            
            Service.uploadBonusPoint(newBonus: newBonus, uid: self.uidFromScaner)
        }
        dismiss(animated: true)
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


