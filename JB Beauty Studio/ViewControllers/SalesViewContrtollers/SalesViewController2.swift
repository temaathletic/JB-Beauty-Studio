//
//  SalesViewController2.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 23.01.2023.
//

import UIKit
import SnapKit

class SalesViewController2: UIViewController {
    
    private var image: UIImageView = {
        let vc = MainViewController()
        let image = vc.picForPH2
        return image
    }()
    
    private let titleText: UILabel = {
        let text = UILabel()
        text.text = "Расскажи друзьям - получи баллы!"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 28)
//        text.textColor = .black
        text.textColor = .white
        text.textAlignment = .center
        text.numberOfLines = 0
        return text
    }()
                           
    private let descriptionText: UILabel = {
        let text = UILabel()
        text.text = "GlacialIndifference GlacialIndifference GlacialIndifference GlacialIndifference GlacialIndifference"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
//        text.textColor = .black
        text.textColor = .white
        text.textAlignment = .left
        text.numberOfLines = 0
        return text
    }()
    
    private let placeholderBG: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "MainBG")
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let placeholder: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "MainBG")!)
        view.addSubview(image)
        view.addSubview(placeholderBG)
        placeholderBG.addSubview(placeholder)
        placeholder.addSubview(titleText)
        placeholder.addSubview(descriptionText)
        
        image.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(320)
        }
        
        placeholderBG.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(image.snp.bottom).inset(40)
            make.bottom.equalToSuperview()
        }
        
        placeholder.snp.makeConstraints { make in
            make.left.right.equalTo(placeholderBG).inset(15)
            make.top.equalTo(placeholderBG).inset(35)
            make.bottom.equalTo(placeholderBG)
        }
        
        titleText.snp.makeConstraints { make in
            make.left.right.equalTo(placeholder).inset(15)
            make.top.equalTo(image.snp.bottom).inset(-20)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.left.right.equalTo(placeholder).inset(15)
            make.top.equalTo(titleText.snp.bottom).inset(-20)
        }
    }
}
