//
//  InviteFriendsViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit

class InviteFriendsViewController: UIViewController {
    
    private let text4: UILabel = {
        let text = UILabel()
        text.text = "+100"
        text.textColor = Color.mainRedColor
        text.textAlignment = .natural
        text.numberOfLines = 0
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        return text
    }()
    
    private let text3: UILabel = {
        let text = UILabel()
        text.text = "Если друг установит \nприложение, используя твой \nпромокод, и сделает первый \nзаказ"
        text.textColor = Color.mainTextColor
        text.numberOfLines = 0
        text.textAlignment = .left
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        text.numberOfLines = 0
        return text
    }()
    
    private let text2: UILabel = {
        let text = UILabel()
        text.text = "Получи баллы за каждого друга"
        text.textColor = Color.mainTextColor
        text.textAlignment = .left
        text.numberOfLines = 0
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 23)
        return text
    }()
    
    private let code: UILabel = {
        let code = UILabel()
        Service.getInviteCode { inviteCode in
            code.text = "\(inviteCode!)"
        }
        code.textColor = Color.mainTextColor
        code.textAlignment = .center
        code.font = UIFont(name: "GlacialIndifference-Bold", size: 45)
        
        return code
    }()
    
    private let text1: UILabel = {
        let text = UILabel()
        text.text = "Поделитесь промокодом"
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 17)
        return text
    }()
    
    private let phForPC: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Поделиться промокодом", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.addTarget(self, action: #selector(tapShareButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc private func tapShareButton() {
        print("Share")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Пригласить друзей"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = Color.mainTextColor
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.mainTextColor!]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = Color.mainTextColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = Color.mainBackgroundColor
        
        
        view.addSubview(phForPC)
        phForPC.addSubview(text1)
        phForPC.addSubview(code)
        view.addSubview(text2)
        view.addSubview(text3)
        view.addSubview(text4)
        view.addSubview(shareButton)
        
        phForPC.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.left.right.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(170)
        }
        
        text1.snp.makeConstraints { make in
            make.left.right.equalTo(phForPC)
            make.top.equalTo(phForPC).inset(30)
        }
        
        code.snp.makeConstraints { make in
            make.top.equalTo(text1.snp.bottom).offset(25)
            make.left.right.equalTo(phForPC)
        }
        
        text2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(text3.snp.top).offset(-20)
        }
        
        text3.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalTo(shareButton.snp.top).offset(-35)
        }
        
        text4.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(text3)
        }
        
        shareButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.left.right.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
    }
}

