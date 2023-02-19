//
//  UserDicrementBonus.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 09.02.2023.
//

import UIKit
import SnapKit
import Lottie

class UserDicrementBonus: UIViewController {
    
    public var uidFromScaner = ""
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Сохранить сумму покупки?"
        label.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        label.textColor = Color.mainTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    public lazy var bonusTextField: UITextField = {
        let textF = UITextField()
        let vc = UserChangeBonus()
        Service.downloadCartSum(uid: uidFromScaner) { variableSum in
            textF.text = variableSum
        }
        textF.textColor = Color.mainTextColor
        textF.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        textF.layer.cornerRadius = 15
        textF.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textF.layer.borderWidth = 1
        textF.leftViewMode = .always
        textF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textF.isUserInteractionEnabled = false
        return textF
    }()
    
    private lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Сохранить", for: .normal)
        btn.setTitleColor(Color.mainTextColor, for: .normal)
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .systemRed
        btn.addTarget(self, action: #selector(decrimentBonus), for: .touchUpInside)
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

extension UserDicrementBonus {
    
    @objc private func decrimentBonus() {
        animateView(saveBtn)
        Service.getPurchaseTotalForDecriment(uid: uidFromScaner) { purchaseTotal in
            let total = purchaseTotal ?? "No Total"
            let textField = self.bonusTextField.text!
            let textFieldInt = Int(textField) ?? 0
            let totalInt = Int(total) ?? 0
            let newPuarchesTotal = totalInt + textFieldInt
            let newBonus = newPuarchesTotal / 100 * 1
            Service.uploadPuarchesTotal(total: "\(newPuarchesTotal)", uid: self.uidFromScaner)
            Service.uploadBonusPoint(newBonus: newBonus, uid: self.uidFromScaner)
            
            self.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
        Service.getUserSecondName(uid: self.uidFromScaner) { secondName in
            Service.getUserFirstName(uid: self.uidFromScaner) { firstName in
                Service.getShopList(uid: self.uidFromScaner) { shopList in
                    let date = Date()
                    let df = DateFormatter()
                    df.dateFormat = "HH:mm:ss dd-MM-yyyy"
                    let dateString = df.string(from: date)
                    Service.uploadINSessionLog(self.uidFromScaner, "\(dateString)", shopList ?? "", firstName ?? "", secondName ?? "")
                }
            }
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

//MARK: - Life Preview

#if DEBUG
import SwiftUI

@available(iOS 15, *)
struct UserBonus: PreviewProvider {
    
    static var previews: some View {
        
        UserDicrementBonus().toPreview()
    }
}
#endif


