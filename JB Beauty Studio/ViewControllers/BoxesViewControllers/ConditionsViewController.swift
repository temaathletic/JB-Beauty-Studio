//
//  ConditionsViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 22.01.2023.
//

import UIKit
import SnapKit

class ConditionsViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let sView = UIScrollView()
        sView.bounces = false
        sView.showsVerticalScrollIndicator = false
        return sView
    }()
    
    private let contentView: UIStackView = {
        let cView = UIStackView()
        cView.spacing = 10
        cView.backgroundColor = .white
        cView.layer.cornerRadius = 25
        cView.axis = .vertical
        return cView
    }()
    
    private let text2: UILabel = {
        let text = UILabel()
        text.text = """
        
        1) Нажмите на купон "предъявить карту и получить баллы", на экране вашего телефона появится QR-код. Покажите его после процедуры.

        2) Косметолог считает код с экрана телефона и вы получите баллы.

        У нас действует накопительная система начисления баллов по общей сумме всех заказов:
        
        До 15 000 рублей - 3%;
        От 15 001 до 30 000 рублей - 5%;
        От 30 001 до 45 000 рублей- 7%;
        От 45 001 и более - 10%
        """
        text.numberOfLines = 0
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        text.textColor = .black
        return text
    }()
    
    private let text1: UILabel = {
        let text = UILabel()
        text.text = "КАК ПОЛУЧИТЬ БАЛЛЫ И ПОТРАТИТЬ ИХ НА ПОДАРКИ?"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 23)
        text.numberOfLines = 0
        text.textColor = .black
        return text
    }()
    
    private let placeholder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgForPriceVC")!)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(placeholder)
        placeholder.addSubview(text1)
        placeholder.addSubview(text2)
        
        scrollView.snp.makeConstraints { make in
            make.width.centerX.height.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.left.right.equalTo(scrollView).inset(15)
            make.bottom.equalTo(scrollView)
            make.top.equalTo(scrollView).inset(60)
        }
        
        placeholder.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.height.equalTo(580)
        }
        
        text1.snp.makeConstraints { make in
            make.left.right.equalTo(placeholder).inset(15)
            make.top.equalTo(placeholder).inset(10)
        }

        text2.snp.makeConstraints { make in
            make.left.right.equalTo(placeholder).inset(15)
            make.top.equalTo(text1.snp.bottom).inset(-10)
        }
    }
}
