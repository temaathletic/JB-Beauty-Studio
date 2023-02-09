//
//  CustomTableViewCellForCart.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 29.01.2023.
//

import UIKit
import SnapKit

class CustomTableViewCellForCart: UITableViewCell {
    
    var backView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var gestureForSwipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipe.direction = .up
        return swipe
    }()
    
    var label: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
        return view
    }()
    
     var price: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(backView)
        backView.addSubview(label)
        backView.addSubview(price)
        
        setBackViewConstraint()
        setPriceConstraint()
        setLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func swipe(_ sender: UISwipeGestureRecognizer) {
        UINavigationController().dismiss(animated: true)
    }
    
    func setBackViewConstraint() {
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func setLabelConstraint() {
        label.snp.makeConstraints { make in
            make.left.equalTo(backView).inset(10)
            make.centerY.equalTo(backView)
            make.height.equalTo(backView)
        }
    }
    
    func setPriceConstraint() {
        price.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.right.equalTo(backView).inset(5)
        }
    }
}

