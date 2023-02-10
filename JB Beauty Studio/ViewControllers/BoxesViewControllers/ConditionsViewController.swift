//
//  ConditionsViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 22.01.2023.
//

import UIKit
import SnapKit

class ConditionsViewController: UIViewController {
    
    private let text2: UILabel = {
        let text = UILabel()
        text.text = """
        
        1) Нажмите на купон "предъявить карту и получить баллы", на экране вашего телефона появится QR-код. Покажите его после процедуры

        2) Косметолог считает код с экрана телефона и вы получите баллы.

        У нас действует накопительная система начисления баллов по общей сумме всех заказов:
        
        До 15 000 рублей - 3%;
        От 15 001 до 30 000 рублей - 5%;
        От 30 001 до 45 000 рублей- 7%;
        От 45 001 и более - 10%
        """
        text.numberOfLines = 0
        text.textColor = .black
        return text
    }()
    
    private let text1: UILabel = {
        let text = UILabel()
        text.text = "КАК ПОЛУЧИТЬ БАЛЛЫ И ПОТРАТИТЬ ИХ НА ПОДАРКИ?"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
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
        view.addSubview(placeholder)
        placeholder.addSubview(text1)
        placeholder.addSubview(text2)
        
        placeholder.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(20)
        }
        
        text1.snp.makeConstraints { make in
            make.left.right.equalTo(placeholder).inset(15)
            make.top.equalTo(placeholder).inset(40)
        }
        
        text2.snp.makeConstraints { make in
            make.left.right.equalTo(placeholder).inset(15)
            make.top.equalTo(text1.snp.bottom).inset(-20)
        }
    }
}
