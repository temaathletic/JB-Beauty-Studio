//
//  CustomTableViewCellForSale.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 15.02.2023.
//

import UIKit
import SnapKit

class CustomTableViewCellForSale: UITableViewCell {
    
    var label: UILabel = {
        let view = UILabel()
        view.textColor = Color.mainTextColor
        view.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
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
        
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
}

