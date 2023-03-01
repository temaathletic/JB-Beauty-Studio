//
//  SideMenuNC.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit
import PhotosUI

class SideMenuNC: UIViewController {
    
    let userDefData = UserDefaults.standard
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var aboutStudio: UILabel = {
        let text = UILabel()
        text.text = "О СТУДИИ"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.addGestureRecognizer(gestureForStudio)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var gestureForStudio: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapAboutStudio))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var personalSale: UILabel = {
        let text = UILabel()
        text.text = "МОЯ СКИДКА"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.addGestureRecognizer(gestureForSale)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var gestureForSale: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPersonalSale))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var inviteFriends: UILabel = {
        let text = UILabel()
        text.text = "ПРИГЛАСИТЬ ДРУЗЕЙ"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.addGestureRecognizer(gestureForInviteFriends)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var gestureForInviteFriends: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapInviteFriends))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var setting: UILabel = {
        let text = UILabel()
        text.text = "НАСТРОЙКИ"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.addGestureRecognizer(gestureSetting)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var gestureSetting: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapSetting))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var techncalSuppourt: UILabel = {
        let text = UILabel()
        text.text = "ТЕХНИЧЕСКАЯ ПОДДЕРЖКА"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.addGestureRecognizer(gestureForTechncalSuppourt)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var gestureForTechncalSuppourt: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapTechncalSupport))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var nameLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 23)
        text.textColor = Color.mainTextColor
        text.numberOfLines = 0
        text.textAlignment = .left
        
        Service.getName { name in
            self.nameLabel.text = name
        }
        return text
    }()
    
    private lazy var phForNameLabel: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.addGestureRecognizer(gestureForName)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var gestureForName: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapProfileLabel))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private let phForAvatar: UIView = {
        let imageView = UIView()
        imageView.layer.cornerRadius = 48
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return imageView
    }()
    
    public var userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 48
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 48
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Service.afterBlock(seconds: 1, queue: .main) {
            imageView.layer.cornerRadius = 48
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 48
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            Service.downloadImages(photo: imageView)
        }
        return imageView
    }()
    
    private let profileLink: UILabel = {
        let text = UILabel()
        text.text = "Профиль"
        text.textColor = Color.mainTextColorWithOppacity
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        return text
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Service.downloadImages(photo: userPhoto)
        Service.getName { name in
            self.nameLabel.text = name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
    
        view.backgroundColor = Color.mainBackgroundColor
        
        view.addSubview(phForAvatar)
        phForAvatar.addSubview(userPhoto)
        view.addSubview(phForNameLabel)
        phForNameLabel.addSubview(profileLink)
        phForNameLabel.addSubview(nameLabel)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(aboutStudio)
        stackView.addArrangedSubview(personalSale)
//        stackView.addArrangedSubview(inviteFriends)
        stackView.addArrangedSubview(setting)
        stackView.addArrangedSubview(techncalSuppourt)
        
        phForAvatar.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(100)
            make.size.equalTo(100)
        }
        
        userPhoto.snp.makeConstraints { make in
            make.center.equalTo(phForAvatar)
            make.size.equalTo(96)
        }
            
        phForNameLabel.snp.makeConstraints { make in
            make.left.equalTo(phForAvatar.snp.right).inset(-40)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(phForAvatar)
            make.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalTo(phForNameLabel)
        }
        
        profileLink.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-2)
            make.left.equalTo(phForNameLabel)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(phForAvatar.snp.bottom).offset(30)
            make.right.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
    }
}
    
    
//MARK: - Function's

extension SideMenuNC {
    
    @objc private func tapAboutStudio(_ gesture: UITapGestureRecognizer) {
        let scene = AboutStudioViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapPersonalSale(_ gesture: UITapGestureRecognizer) {
        let scene = PersonalSaleViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapInviteFriends(_ gesture: UITapGestureRecognizer) {
        let scene = InviteFriendsViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapSetting(_ gesture: UITapGestureRecognizer) {
        let scene = SettingViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapTechncalSupport(_ gesture: UITapGestureRecognizer) {
        let scene = TechnichalSupportViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapProfileLabel(_ gesture: UITapGestureRecognizer) {
        let scene = ProfileSettingViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
}



