//
//  PersonalSaleViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 10.02.2023.
//

import UIKit
import SnapKit

class PersonalSaleViewController: UIViewController {
    
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.layer.cornerRadius = 16
        bar.setProgress(0, animated: true)
        Service.getPurchaseTotal { purchaseTotal in
            
            let total = purchaseTotal ?? ""
            let myFloat = Float(total) ?? 0
            let myInt = Int(total) ?? 0
            
            Service.getPurchaseTotal { purchaseTotal in
                
                if myInt >= 0 {
                    Service.uploadSale(sale: "3%")
                } else if myInt >= 15001 {
                    Service.uploadSale(sale: "5%")
                } else if myInt >= 35001 {
                    Service.uploadSale(sale: "7%")
                } else if myInt >= 45001 {
                    Service.uploadSale(sale: "10%")
                }
            }
            
            print("Total -> \(total)")
            print("myInt -> \(myInt)")
            
            let action = myFloat / 45000
        
            bar.setProgress(action, animated: true)
        }
        bar.tintColor = Color.mainRedColor
        return bar
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш прогресс"
        label.font = UIFont(name: "GlacialIndifference-Bold", size: 35)
        label.textColor = Color.mainTextColor
        label.textAlignment = .left
        return label
    }()
    
    private let saleLabel: UILabel = {
        let label = UILabel()
        label.text = "Скидка"
        label.font = UIFont(name: "GlacialIndifference-Bold", size: 35)
        label.textColor = Color.mainTextColor
        return label
    }()
    
    private let saleLetter: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GlacialIndifference-Bold", size: 35)
        label.textColor = Color.mainTextColor
        return label
    }()
    
    private let bonusLabel: UILabel = {
        let bonus = UILabel()
        bonus.text = "Бонусы"
        bonus.font = UIFont(name: "GlacialIndifference-Regualr", size: 12)
        bonus.textColor = Color.mainTextColor
        return bonus
    }()
    
    private let bonusPoint: UILabel = {
        let bonus = UILabel()
        Service.getBonusPoint { bonusPoint in
            guard let optionalBonus = bonusPoint else { return }
            bonus.text = "\(optionalBonus)"
        }
        bonus.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        bonus.textColor = Color.mainTextColor
        return bonus
    }()
    
    private lazy var infoIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "info.circle")
        image.contentMode = .scaleAspectFill
        image.tintColor = Color.mainTextColorWithOppacity
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(gestureForInfo)
        return image
    }()
    
    private lazy var gestureForInfo: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(infoTapped))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        return tap
    }()
    
    private let showCard: UIView = {
        let card = UIView()
        card.backgroundColor = Color.mainRedWithOppacity
        card.layer.cornerRadius = 20
        return card
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Service.getSale { sale in
            self.saleLetter.text = sale
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        Service.getPurchaseTotal { purchaseTotal in
            
            let total = purchaseTotal ?? ""
            let myInt = Int(total) ?? 0
            
            Service.getPurchaseTotal { purchaseTotal in
                print("Print my int -> \(myInt)")
                if myInt != 0 && myInt < 15001 {
                    Service.uploadSale(sale: "3%")
                } else if myInt >= 15001 && myInt < 35001 {
                    Service.uploadSale(sale: "5%")
                } else if myInt >= 35001 && myInt < 45001 {
                    Service.uploadSale(sale: "7%")
                } else if myInt >= 45001 && myInt < 1000000 {
                    Service.uploadSale(sale: "10%")
                }
            }
            
            print("Total -> \(total)")
            print("myInt -> \(myInt)")
        }
        
        title = "Моя скидка"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = Color.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Color.mainTextColor!]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = Color.mainTextColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = Color.mainBackgroundColor
        
        createCircleProgress(price: 0, sale: "3%")
        createCircleProgress3(price: 35000, sale: "7%")
        createCircleProgress2(price: 15000, sale: "5%")
        createCircleProgress4(price: 45000, sale: "10%")
        
        view.addSubview(showCard)
        view.addSubview(progressLabel)
        view.addSubview(progressBar)
        showCard.addSubview(saleLabel)
        showCard.addSubview(saleLetter)
        showCard.addSubview(infoIcon)
        showCard.addSubview(bonusLabel)
        showCard.addSubview(bonusPoint)
        
        showCard.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(230)
        }
        
        saleLabel.snp.makeConstraints { make in
            make.left.top.equalTo(showCard).inset(15)
        }
        
        saleLetter.snp.makeConstraints { make in
            make.top.equalTo(saleLabel.snp.bottom).inset(-10)
            make.left.equalTo(showCard).inset(15)
        }
        
        bonusLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bonusPoint.snp.top).inset(-10)
            make.left.equalTo(showCard).inset(15)
        }
        
        bonusPoint.snp.makeConstraints { make in
            make.left.bottom.equalTo(showCard).inset(15)
        }
        
        infoIcon.snp.makeConstraints { make in
            make.top.right.equalTo(showCard).inset(15)
            make.size.equalTo(30)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(showCard.snp.bottom).inset(-30)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).inset(-50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(8)
        }
    }
}

extension PersonalSaleViewController {
    
    @objc func infoTapped() {
        let vc = ConditionsViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    func createCircleProgress(price: Int, sale: String) {
        
        let circle: UIView = {
            let circle = UIView()
            circle.backgroundColor = Color.mainRedColor
            circle.layer.cornerRadius = 7
            return circle
        }()
        
        let discount: UILabel = {
            let text = UILabel()
            text.text = sale
            text.textColor = Color.mainTextColor
            text.textAlignment = .center
            text.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
            return text
        }()
        
        let price: UILabel = {
            let text = UILabel()
            text.text = "\(price)"
            text.textColor = Color.mainTextColor
            text.textAlignment = .center
            text.font = UIFont(name: "GlacialIndifference-Bold", size: 16)
            return text
        }()
        
        progressBar.addSubview(circle)
        progressBar.addSubview(discount)
        progressBar.addSubview(price)
        
        circle.snp.makeConstraints { make in
            make.left.centerY.equalTo(progressBar)
            make.size.equalTo(14)
        }
        
        discount.snp.makeConstraints { make in
            make.bottom.equalTo(circle.snp.top).inset(-10)
            make.centerX.equalTo(circle)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(circle.snp.bottom).inset(-10)
            make.centerX.equalTo(circle)
        }
    }
    
    func createCircleProgress2(price: Int, sale: String) {
        
        let circle: UIView = {
            let circle = UIView()
            circle.backgroundColor = Color.mainRedColor
            circle.layer.cornerRadius = 7
            return circle
        }()
        
        let discount: UILabel = {
            let text = UILabel()
            text.text = sale
            text.textColor = Color.mainTextColor
            text.textAlignment = .center
            text.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
            return text
        }()
        
        let price: UILabel = {
            let text = UILabel()
            text.text = "\(price)"
            text.textColor = Color.mainTextColor
            text.textAlignment = .center
            text.font = UIFont(name: "GlacialIndifference-Bold", size: 16)
            return text
        }()
        
        progressBar.addSubview(circle)
        progressBar.addSubview(discount)
        progressBar.addSubview(price)
        
        circle.snp.makeConstraints { make in
            make.centerY.equalTo(progressBar)
            make.left.equalTo(progressBar).inset(120)
            make.size.equalTo(14)
        }
        
        discount.snp.makeConstraints { make in
            make.bottom.equalTo(circle.snp.top).inset(-10)
            make.centerX.equalTo(circle)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(circle.snp.bottom).inset(-10)
            make.centerX.equalTo(circle)
        }
    }
    
    func createCircleProgress3(price: Int, sale: String) {
        
        let circle: UIView = {
            let circle = UIView()
            circle.backgroundColor = Color.mainRedColor
            circle.layer.cornerRadius = 7
            return circle
        }()
        
        let discount: UILabel = {
            let text = UILabel()
            text.text = sale
            text.textColor = Color.mainTextColor
            text.textAlignment = .center
            text.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
            return text
        }()
        
        let price: UILabel = {
            let text = UILabel()
            text.text = "\(price)"
            text.textColor = Color.mainTextColor
            text.textAlignment = .center
            text.font = UIFont(name: "GlacialIndifference-Bold", size: 16)
            return text
        }()
        
        progressBar.addSubview(circle)
        progressBar.addSubview(discount)
        progressBar.addSubview(price)
        
        circle.snp.makeConstraints { make in
            make.centerY.equalTo(progressBar)
            make.right.equalTo(progressBar).inset(80)
            make.size.equalTo(14)
        }
        
        discount.snp.makeConstraints { make in
            make.bottom.equalTo(circle.snp.top).inset(-10)
            make.centerX.equalTo(circle)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(circle.snp.bottom).inset(-10)
            make.centerX.equalTo(circle)
        }
    }
    
    func createCircleProgress4(price: Int, sale: String) {
        
        let circle: UIView = {
            let circle = UIView()
            circle.backgroundColor = Color.mainRedColor
            circle.layer.cornerRadius = 7
            return circle
        }()
        
        let discount: UILabel = {
            let text = UILabel()
            text.text = sale
            text.textColor = Color.mainTextColor
            text.textAlignment = .center
            text.font = UIFont(name: "GlacialIndifference-Regular", size: 16)
            return text
        }()
        
        let price: UILabel = {
            let text = UILabel()
            text.text = "\(price)"
            text.textColor = Color.mainTextColor
            text.textAlignment = .center
            text.font = UIFont(name: "GlacialIndifference-Bold", size: 16)
            return text
        }()
        
        progressBar.addSubview(circle)
        progressBar.addSubview(discount)
        progressBar.addSubview(price)
        
        circle.snp.makeConstraints { make in
            make.right.centerY.equalTo(progressBar)
            make.size.equalTo(14)
        }
        
        discount.snp.makeConstraints { make in
            make.bottom.equalTo(circle.snp.top).inset(-10)
            make.centerX.equalTo(circle)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(circle.snp.bottom).inset(-10)
            make.centerX.equalTo(circle)
        }
    }
}
