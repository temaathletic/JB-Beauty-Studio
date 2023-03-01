//
//  PopUpViewController3-1.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 09.01.2023.
//

import UIKit
import SnapKit

class PopUpViewController3_1: UIViewController {
    
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
    
    @objc func tap() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = Color.mainBackgroundColor
        view.addSubview(labelTitle)
        view.addSubview(label)
        view.addSubview(sendButton)
        
        labelTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets).inset(25)
        }
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(labelTitle.snp.bottom).inset(-25)
        }
        
        sendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(view.frame.height / 30)
            make.size.equalTo(60)
        }
    }
}


