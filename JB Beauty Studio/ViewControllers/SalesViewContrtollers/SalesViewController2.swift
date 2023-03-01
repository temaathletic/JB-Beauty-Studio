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
        let image = UIImageView()
        Service.downloadImagesForSaleBox(photo: image, name: "SaleBox2_1")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let titleText: UILabel = {
        let text = UILabel()
//        text.text = "Расскажи друзьям - получи баллы!"
        Service.downloadTextForSaleBox2 { newText in
            text.text = newText
        }
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 28)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        text.numberOfLines = 0
        return text
    }()
                           
    private let descriptionText: UILabel = {
        let text = UILabel()
//        text.text = "GlacialIndifference GlacialIndifference GlacialIndifference GlacialIndifference GlacialIndifference"
        Service.downloadTitleForSaleBox2 { newText in
            text.text = newText
        }
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        text.textColor = Color.mainTextColor
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
        placeholderBG.addSubview(titleText)
        placeholderBG.addSubview(descriptionText)
        
        image.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(320)
        }
        
        placeholderBG.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(image.snp.bottom).inset(40)
            make.bottom.equalToSuperview()
        }
        
        titleText.snp.makeConstraints { make in
            make.left.right.equalTo(placeholderBG).inset(15)
            make.top.equalTo(placeholderBG).inset(20)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.left.right.equalTo(placeholderBG).inset(15)
            make.top.equalTo(titleText.snp.bottom).inset(-20)
        }
    }
}
