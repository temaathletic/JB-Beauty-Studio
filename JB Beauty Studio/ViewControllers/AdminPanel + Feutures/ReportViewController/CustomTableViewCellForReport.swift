//
//  CustomTableViewCellForReport.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 18.02.2023.
//

import UIKit
import SnapKit

class CustomTableViewCellForReport: UITableViewCell {
    
    var backView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var emailLabel: UILabel = {
        let view = UILabel()
        view.textColor = Color.mainTextColor
        view.textAlignment = .left
        view.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
        view.numberOfLines = 0
        return view
    }()
    
    var shopList: UILabel = {
        let view = UILabel()
        view.textColor = Color.mainTextColor
        view.textAlignment = .left
        view.numberOfLines = 0
        view.font = UIFont(name: "GlacialIndifference-Regular", size: 14)
        return view
    }()
    
    var messageLabel: UILabel = {
        let view = UILabel()
        view.textColor = Color.mainTextColor
        view.textAlignment = .left
        view.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
        view.numberOfLines = 0
        return view
    }()
    
    var locationLabel: UILabel = {
        let view = UILabel()
        view.textColor = Color.mainTextColor
        view.textAlignment = .left
        view.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
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
        backView.addSubview(emailLabel)
        backView.addSubview(shopList)
        backView.addSubview(messageLabel)
//        backView.addSubview(locationLabel)
    
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(170)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.left.equalTo(backView).inset(10)
            make.top.equalTo(backView).inset(10)
            make.height.equalTo(25)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-10)
            make.left.right.equalTo(backView).inset(10)
        }

//        shopList.snp.makeConstraints { make in
//            make.top.equalTo(messageLabel.snp.bottom).inset(-10)
//            make.left.right.equalTo(backView).inset(10)
//            make.bottom.equalTo(backView).inset(10)
//        }
        
//        locationLabel.snp.makeConstraints { make in
//            make.top.equalTo(dateLabel.snp.bottom).inset(-10)
//            make.left.equalTo(backView).inset(10)
//            make.height.equalTo(25)
//        }
    }
}




