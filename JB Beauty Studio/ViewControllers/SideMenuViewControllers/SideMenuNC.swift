//
//  SideMenuNC.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit
import PhotosUI
import SkeletonView

class SideMenuNC: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var text1: UILabel = {
        let text = UILabel()
        text.text = "О СТУДИИ"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = .black
        text.addGestureRecognizer(gestureForText1)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var gestureForText1: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapText1))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var text2: UILabel = {
        let text = UILabel()
        text.text = "ПРИГЛАСИТЬ ДРУЗЕЙ"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = .black
        text.addGestureRecognizer(gestureForText2)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var gestureForText2: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapText2))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var text3: UILabel = {
        let text = UILabel()
        text.text = "НАСТРОЙКИ"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.addGestureRecognizer(gestureSetting)
        text.isUserInteractionEnabled = true
        text.textColor = .black
        return text
    }()
    
    private lazy var gestureSetting: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapSetting))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var text4: UILabel = {
        let text = UILabel()
        text.text = "ТЕХНИЧЕСКАЯ ПОДДЕРЖКА"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = .black
        text.addGestureRecognizer(gestureForText4)
        text.isUserInteractionEnabled = true
        return text
    }()
    
    private lazy var gestureForText4: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapText4))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var nameLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 23)
        text.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapQR))
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
    
    private let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: .systemGray2, secondaryColor: .systemGray4))
        imageView.layer.cornerRadius = 48
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 48
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Service.afterBlock(seconds: 3, queue: .main) {
            imageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0))
            imageView.layer.cornerRadius = 48
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 48
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        Service.afterBlock(seconds: 2, queue: .global()) {
            Service.downloadImages(photo: imageView)
        }
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
    
        view.backgroundColor = .white
        
        view.addSubview(phForAvatar)
        phForAvatar.addSubview(userPhoto)
        view.addSubview(phForNameLabel)
        phForNameLabel.addSubview(nameLabel)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(text1)
        stackView.addArrangedSubview(text2)
        stackView.addArrangedSubview(text3)
        stackView.addArrangedSubview(text4)
        
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
            make.left.equalTo(phForAvatar.snp.right)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(phForAvatar)
            make.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.center.equalTo(phForNameLabel)
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
    
    @objc private func tapText1(_ gesture: UITapGestureRecognizer) {
        let scene = AboutStudioViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapText2(_ gesture: UITapGestureRecognizer) {
        let scene = InviteFriendsViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapSetting(_ gesture: UITapGestureRecognizer) {
        let scene = SettingViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapText4(_ gesture: UITapGestureRecognizer) {
        let scene = TechnichalSupportViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapQR(_ gesture: UITapGestureRecognizer) {
        let scene = ProfileSettingViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
}




