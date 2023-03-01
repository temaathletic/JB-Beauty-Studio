//
//  PopUpPriceViewController1.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 29.01.2023.
//

import UIKit
import SnapKit

class PopUpPriceViewController1: UIViewController {
    
    private let labelTitle: UILabel = {
        let text = UILabel()
        text.text = "Биоревитализация"
        text.numberOfLines = 0
        text.textAlignment = .center
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let label: UILabel = {
        let text = UILabel()
        text.text = "Биоревитализация - Процедура способна оказать быстрое омолаживающее действие и справляется со всеми возрастными изменениями."
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
        animateView(sendButton)
        dismiss(animated: true)
    }
    
    @objc func addToCart() {
        let vc = ShopCartViewController()
        vc.createItem(name: ProcedureName.procedureName1, price: (ProcedurePrice.procedurePrice1), quantity: 1)
        animateView(cartButton)
        self.dismiss(animated: true)
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

extension PopUpPriceViewController1 {
    
    private func animateView(_ viewAnimate: UIView) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations:  {
            viewAnimate.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { (_) in
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.4, options: .curveEaseIn) {
                viewAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}

