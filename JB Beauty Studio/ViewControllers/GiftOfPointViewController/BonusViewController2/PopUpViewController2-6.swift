//
//  PopUpViewController2-6.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 09.01.2023.
//

import UIKit
import BottomPopup
import SnapKit

class PopUpViewController2_6: BottomPopupViewController {
    
    private let labelTitle: UILabel = {
        let text = UILabel()
        text.text = "Гипергидроз мужской"
        text.numberOfLines = 0
        text.textAlignment = .center
        text.textColor = .black
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let label: UILabel = {
        let text = UILabel()
        text.text = "Гипергидроз - Лечение повышенного потоотделение в области подмышек, стоп и ладоней."
        text.numberOfLines = 0
        text.textAlignment = .left
        text.textColor = .black
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        return text
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
    
    @objc func tap() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        view.addSubview(labelTitle)
        view.addSubview(label)
        view.addSubview(sendButton)
        
        labelTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(10)
        }
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(labelTitle).inset(20)
            make.bottom.equalTo(sendButton.snp.top)
        }
        
        sendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.size.equalTo(60)
        }
    }
}


