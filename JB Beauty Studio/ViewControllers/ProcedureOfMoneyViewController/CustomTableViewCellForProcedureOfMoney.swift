//
//  CustomTableViewCell2.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 28.01.2023.
//

import UIKit
import SnapKit

class CustomTableViewCellForProcedureOfMoney: UITableViewCell {
    
    var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
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
        view.textColor = .white
        view.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        return view
    }()
    
    var circle = UIView()
    
    lazy var price: UILabel = {
        let view = UILabel()
        view.textColor = .white
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
    
    @objc func swipe(_ sender: UISwipeGestureRecognizer) {
        UINavigationController().dismiss(animated: true)
    }
    
    func setupView() {
        
        backgroundColor = .white
        
        addSubview(backView)
        backView.addSubview(label)
        backView.addSubview(circle)
        circle.addSubview(price)
        
        circle.layer.cornerRadius = 37
        circle.clipsToBounds = true
        circle.backgroundColor = Color.mainRedColor
        
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(15)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(backView).inset(10)
            make.centerY.equalTo(backView)
            make.height.equalTo(backView)
            make.right.equalTo(circle.snp.left)
        }
        
        circle.snp.makeConstraints { make in
            make.size.equalTo(75)
            make.centerY.equalTo(backView)
            make.right.equalTo(backView).offset(5)
        }
        
        price.snp.makeConstraints { make in
            make.centerY.equalTo(circle)
            make.left.right.equalTo(circle).inset(5)
        }
    }
}
