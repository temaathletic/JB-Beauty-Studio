//
//  CustomTableViewCellForCart.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 29.01.2023.
//

import UIKit
import SnapKit
import SwipeCellKit

class CustomTableViewCellForCart: SwipeTableViewCell {
    
    var backView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var label: UILabel = {
        let view = UILabel()
        view.textColor = Color.mainTextColor
        view.textAlignment = .left
        view.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
        view.numberOfLines = 0
        return view
    }()
    
    var placeholderForPlaceholder: UIView = {
        let ph = UIView()
        ph.backgroundColor = .none
        ph.layer.cornerRadius = 10
        ph.isUserInteractionEnabled = true
        return ph
    }()
    
    var placeholderForQuantity: UIView = {
        let ph = UIView()
        ph.backgroundColor = .systemGray4.withAlphaComponent(0.5)
        ph.layer.cornerRadius = 10
        ph.isUserInteractionEnabled = true
        return ph
    }()
    
     lazy var plusButton: UIButton = {
        let symbol = UIButton()
        symbol.setTitle("+", for: .normal)
        symbol.tintColor = Color.mainTextColor
        symbol.setTitleColor(.black, for: .normal)
        symbol.isUserInteractionEnabled = true
        symbol.addTarget(self, action: #selector(plus), for: .touchUpInside)
        return symbol
    }()
    
     lazy var minusButton: UIButton = {
        let symbol = UIButton()
        symbol.setImage(UIImage(systemName: "minus"), for: .normal)
        symbol.setTitleColor(.black, for: .normal)
        symbol.tintColor = Color.mainTextColor
        symbol.isUserInteractionEnabled = true
        symbol.addTarget(self, action: #selector(plus), for: .touchUpInside)
        return symbol
    }()
    
    var quantityLabel: UILabel = {
        let quantity = UILabel()
        quantity.textColor = Color.mainTextColor
        quantity.textAlignment = .center
        quantity.font = UIFont(name: "GlacialIndifference-Bold", size: 16)
        return quantity
    }()
    
    var currency: UILabel = {
        let view = UILabel()
        view.text = "₽"
        view.textColor = Color.mainTextColor
        view.textAlignment = .center
        view.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        return view
    }()
    
    var price: UILabel = {
        let view = UILabel()
        view.textColor = Color.mainTextColor
        view.textAlignment = .center
        view.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        backgroundColor = Color.mainBackgroundColor
        
        addSubview(backView)
        backView.addSubview(label)
        backView.addSubview(price)
        backView.addSubview(currency)
    
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(backView).inset(10)
            make.centerY.equalTo(backView)
            make.height.equalTo(50)
        }
        
        currency.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerY.equalTo(price)
            make.right.equalTo(backView).inset(10)
        }

        price.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.height.equalTo(50)
            make.right.equalTo(currency.snp.left).inset(-3)
        }
    }
    
    @objc private func plus() {
        print("+")
    }
    
    @objc func swipe(_ sender: UISwipeGestureRecognizer) {
        UINavigationController().dismiss(animated: true)
    }
    
    private lazy var gestureForSwipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipe.direction = .up
        return swipe
    }()
}

