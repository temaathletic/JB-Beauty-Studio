//
//  CustomTableViewCellForSearchPeople.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 08.02.2023.
//

import UIKit
import SnapKit

class CustomTableViewCellForSearchPeople: UITableViewCell {
    
    var backView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = Color.mainTextColor
        view.textAlignment = .left
        view.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
        view.numberOfLines = 0
        return view
    }()
    
    var loginLabel: UILabel = {
        let view = UILabel()
        view.textColor = Color.mainTextColor
        view.textAlignment = .left
        view.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
        return view
    }()
    
    var numberLabel: UILabel = {
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
        backView.addSubview(nameLabel)
        backView.addSubview(loginLabel)
        backView.addSubview(numberLabel)
        backView.addSubview(locationLabel)
    
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(150)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(backView).inset(10)
            make.top.equalTo(backView).inset(10)
            make.height.equalTo(25)
        }

        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-10)
            make.left.equalTo(backView).inset(10)
            make.height.equalTo(25)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).inset(-10)
            make.left.equalTo(backView).inset(10)
            make.height.equalTo(25)
        }

        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).inset(-10)
            make.left.equalTo(backView).inset(10)
            make.height.equalTo(25)
        }
    }
}


