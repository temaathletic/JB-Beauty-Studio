//
//  LocationViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit

class LocationViewController: UIViewController {
    
    private lazy var callButt: UIButton = {
        let button = UIButton()
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.08235294118, blue: 0, alpha: 1)
        button.addTarget(self, action: #selector(tapCall), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    @objc private func tapWrite() {
        openUrl(urlString: "https://wa.me/+79180142070")
    }
    
    private lazy var whtasAppBut: UIButton = {
        let button = UIButton()
        button.setTitle("Написать", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.08235294118, blue: 0, alpha: 1)
        button.addTarget(self, action: #selector(tapWrite), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    @objc private func tapCall() {
        callPhone(string: "tel://89180142070")
    }
    
    private let phForCity1: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 0.3)
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private let phForCity2: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 0.3)
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private let phForCity3: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 0.3)
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private let city1: UILabel = {
        let text = UILabel()
        text.text = "г. Армавир"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = .black
        return text
    }()
    
    private let city2: UILabel = {
        let text = UILabel()
        text.text = "г. Ростов на Дону"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = .black
        return text
    }()
    
    private let city3: UILabel = {
        let text = UILabel()
        text.text = "г. Краснодар"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 17)
        text.textColor = .black
        return text
    }()
    
    @objc private func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc private func callPhone(string: String) {
            UIApplication.shared.open(NSURL(string: string)! as URL)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Местоположение"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.addSubview(callButt)
        view.addSubview(whtasAppBut)
        view.addSubview(phForCity1)
        view.addSubview(phForCity2)
        view.addSubview(phForCity3)
        phForCity1.addSubview(city1)
        phForCity2.addSubview(city2)
        phForCity3.addSubview(city3)
        
        callButt.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.width.equalTo(view.frame.width / 2.5)
        }
        
        whtasAppBut.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.width.equalTo(view.frame.width / 2.5)
        }
        
        phForCity1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(135)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(45)
        }
        
        city1.snp.makeConstraints { make in
            make.left.top.equalTo(phForCity1).inset(30)
        }
        
        phForCity2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(135)
            make.top.equalTo(phForCity1.snp.bottom).offset(35)
        }
        
        city2.snp.makeConstraints { make in
            make.left.top.equalTo(phForCity2).inset(30)
        }
        
        phForCity3.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(135)
            make.top.equalTo(phForCity2.snp.bottom).offset(35)
        }
        
        city3.snp.makeConstraints { make in
            make.left.top.equalTo(phForCity3).inset(30)
        }
    }
}
