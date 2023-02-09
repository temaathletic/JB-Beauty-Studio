//
//  AboutStudioViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit

class AboutStudioViewController: UIViewController {
    
    private let firstText: UILabel = {
        let text = UILabel()
        text.text = "О ПРИЛОЖЕНИИ"
        text.textColor = Color.mainTextColor
        text.textAlignment = .left
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        text.numberOfLines = 0
        return text
    }()
    
    private let firstDescription: UILabel = {
        let text = UILabel()
        text.text = "Станьте частью JB Beauty Studio с помощью нашего мобильного приложения!"
        text.textColor = Color.mainTextColor
        text.textAlignment = .left
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        text.numberOfLines = 0
        return text
    }()
    
    private let secondText: UILabel = {
        let text = UILabel()
        text.text = "ПОЛУЧАЙТЕ ПОДАРКИ"
        text.textColor = Color.mainTextColor
        text.textAlignment = .left
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        text.numberOfLines = 0
        return text
    }()
    private let secondDescription: UILabel = {
        let text = UILabel()
        text.text = "Копите баллы за каждую процедуру и обменивайте их на подарки."
        text.textColor = Color.mainTextColor
        text.textAlignment = .left
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        text.numberOfLines = 0
        return text
    }()
    
    private let thirdText: UILabel = {
        let text = UILabel()
        text.text = "ОСТАВЛЯЙТЕ ОТЗЫВЫ"
        text.textColor = Color.mainTextColor
        text.textAlignment = .left
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        text.numberOfLines = 0
        return text
    }()
    
    private let thirdDescription: UILabel = {
        let text = UILabel()
        text.text = "Помогите нам стать еще лучше оставляя отзывы в приложении.\nИспользуя приложение, вы соглашаетесь с нашими правилами"
        text.textColor = Color.mainTextColor
        text.textAlignment = .left
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        text.numberOfLines = 0
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "JB Beauty Studio"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = Color.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Color.mainTextColor!]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = Color.mainTextColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = Color.mainBackgroundColor
        view.addSubview(firstText)
        view.addSubview(secondText)
        view.addSubview(thirdText)
        view.addSubview(firstDescription)
        view.addSubview(secondDescription)
        view.addSubview(thirdDescription)
        
        firstText.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(35)
        }
        
        firstDescription.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(firstText.snp.bottom).inset(-25)
        }
        
        secondText.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(firstDescription.snp.bottom).inset(-40)
        }
        
        secondDescription.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(secondText.snp.bottom).inset(-25)
        }
        
        thirdText.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(secondDescription.snp.bottom).inset(-40)
        }
        
        thirdDescription.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(thirdText.snp.bottom).inset(-25)
        }
    }
}

