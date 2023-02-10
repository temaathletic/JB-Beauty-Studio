//
//  PopUpPriceViewController18.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 29.01.2023.
//

import UIKit
import BottomPopup
import SnapKit

class PopUpPriceViewController18: BottomPopupViewController {
    
    private let labelTitle: UILabel = {
        let text = UILabel()
        text.text = "Лоб"
        text.numberOfLines = 0
        text.textAlignment = .center
        text.textColor = .black
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let label: UILabel = {
        let text = UILabel()
        text.text = "Ботулинотерапия лба - Расслабляет лобную мышцу, кожа «отдыхает», и при мимической нагрузке морщины не образуется. При этом сохраняется живая мимика лица."
        text.numberOfLines = 0
        text.textAlignment = .left
        text.textColor = .black
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        return text
    }()
    
    private let placeholderForButtons: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        return view
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart.fill.badge.plus"), for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        return button
    }()
    
    @objc func tap() {
        dismiss(animated: true)
    }
    
    @objc func addToCart() {
        let vc = ShopCartViewController()
        vc.createItem(name: ProcedureName.procedureName18, price: Int64(ProcedurePrice.procedurePrice18), quantity: 1)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        view.addSubview(labelTitle)
        view.addSubview(label)
        view.addSubview(placeholderForButtons)
        placeholderForButtons.addSubview(sendButton)
        placeholderForButtons.addSubview(cartButton)
        
        labelTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(10)
        }
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(labelTitle.snp.bottom).inset(-20)
        }
        
        placeholderForButtons.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(60)
            make.width.equalTo(140)
        }
        
        sendButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.left.equalTo(placeholderForButtons)
        }
        
        cartButton.snp.makeConstraints { make in
            make.right.equalTo(placeholderForButtons)
            make.size.equalTo(60)
        }
    }
}


