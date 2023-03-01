//
//  PopUpPriceViewController10.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 29.01.2023.
//

import UIKit
import SnapKit

class PopUpPriceViewController10: UIViewController {
    
    private let labelTitle: UILabel = {
        let text = UILabel()
        text.text = "Исправление Губ"
        text.numberOfLines = 0
        text.textAlignment = .center
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let label: UILabel = {
        let text = UILabel()
        text.text = "Контурная пластика губ - Увеличение объема, коррекция формы и асимметрии, увлажнение, коррекция уголков губ."
        text.numberOfLines = 0
        text.textAlignment = .left
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
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
        button.tintColor = Color.mainTextColor
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.08235294118, blue: 0, alpha: 1)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart.fill.badge.plus"), for: .normal)
        button.tintColor = Color.mainTextColor
        button.setTitleColor(Color.mainTextColor, for: .normal)
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
        vc.createItem(name: ProcedureName.procedureName10, price: Int64(ProcedurePrice.procedurePrice10), quantity: 1)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = Color.mainBackgroundColor
        view.addSubview(labelTitle)
        view.addSubview(label)
        view.addSubview(placeholderForButtons)
        placeholderForButtons.addSubview(sendButton)
        placeholderForButtons.addSubview(cartButton)
        
        labelTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets).inset(25)
        }
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(labelTitle.snp.bottom).inset(-25)
        }
        
        placeholderForButtons.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(view.frame.height / 30)
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


