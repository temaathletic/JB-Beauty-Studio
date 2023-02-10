//
//  WrittenViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit


class WrittenViewController: UIViewController {
    
    private lazy var textTelegram: UILabel = {
        let text = UILabel()
        text.text = "Переходите в наш Telegram для записи"
        text.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        text.numberOfLines = 0
        
        return text
    }()
    
    private lazy var textInsta: UILabel = {
        let text = UILabel()
        text.text = "Переходите в наш Instagram для записи"
        text.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        text.numberOfLines = 0
        
        return text
    }()
    
    private lazy var textWhatsApp: UILabel = {
        let text = UILabel()
        text.text = "Переходите в наш What's App для записи"
        text.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        text.numberOfLines = 0
        
        return text
    }()
    
    private lazy var placeholderFor1: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        return view
    }()
    
    private lazy var placeholderFor2: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        return view
    }()
    
    private lazy var placeholderFor3: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        return view
    }()
    
    private lazy var telegramButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "telegram.png"), for: .normal)
        view.layer.shadowColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        
        
        view.addTarget(self, action: #selector(onClicLabel1), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var instagramButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "instagram.png"), for: .normal)
        view.layer.shadowColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        
        
        view.addTarget(self, action: #selector(onClicLabel3), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var whatsAppButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "whatsapp.png"), for: .normal)
        view.layer.shadowColor = UIColor.green.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        
        
        view.addTarget(self, action: #selector(onClicLabel2), for: .touchUpInside)
        
        return view
    }()
    
    @objc private func onClicLabel1() {
        openUrl(urlString: "https://t.me/Svytobog")
    }
    
    @objc private func onClicLabel2() {
        openUrl(urlString: "http://www.whatsapp.com")
    }
    
    @objc private func onClicLabel3() {
        openUrl(urlString: "http://www.instagram.com")
    }
    
    @objc private func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    private lazy var customName: UILabel = {
        let name = UILabel()
        name.text = "Запись"
        name.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        
        return name
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(customName)
        view.addSubview(placeholderFor1)
        view.addSubview(placeholderFor2)
        view.addSubview(placeholderFor3)
        placeholderFor1.addSubview(telegramButton)
        placeholderFor1.addSubview(textTelegram)
        placeholderFor3.addSubview(instagramButton)
        placeholderFor3.addSubview(textInsta)
        placeholderFor2.addSubview(whatsAppButton)
        placeholderFor2.addSubview(textWhatsApp)
        
        
        placeholderFor1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.left.equalToSuperview().inset(15)
            make.height.equalTo(80)
            make.width.equalTo(300)
        }
        
        textTelegram.snp.makeConstraints { make in
            make.left.equalTo(telegramButton.snp.right).offset(15)
            make.right.equalTo(placeholderFor1)
            make.centerY.equalTo(placeholderFor1)
        }
        
        telegramButton.snp.makeConstraints { make in
            make.left.equalTo(placeholderFor1).inset(15)
            make.centerY.equalTo(placeholderFor1)
            make.size.equalTo(64)
        }
        
        placeholderFor2.snp.makeConstraints { make in
            make.top.equalTo(placeholderFor1.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.height.equalTo(80)
            make.width.equalTo(300)
        }
        
        textWhatsApp.snp.makeConstraints { make in
            make.left.equalTo(telegramButton.snp.right).offset(15)
            make.right.equalTo(placeholderFor2)
            make.centerY.equalTo(placeholderFor2)
        }
        
        whatsAppButton.snp.makeConstraints { make in
            make.left.equalTo(placeholderFor2).inset(15)
            make.centerY.equalTo(placeholderFor2)
            make.size.equalTo(64)
        }
        
        placeholderFor3.snp.makeConstraints { make in
            make.top.equalTo(placeholderFor2.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.height.equalTo(80)
            make.width.equalTo(300)
        }
        
        instagramButton.snp.makeConstraints { make in
            make.left.equalTo(placeholderFor3).inset(15)
            make.centerY.equalTo(placeholderFor3)
            make.size.equalTo(64)
        }
        
        textInsta.snp.makeConstraints { make in
            make.left.equalTo(telegramButton.snp.right).offset(15)
            make.right.equalTo(placeholderFor3)
            make.centerY.equalTo(placeholderFor3)
        }
        
        customName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(25)
        }
        
    }
}

