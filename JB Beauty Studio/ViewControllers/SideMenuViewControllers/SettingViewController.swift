//
//  SettingViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit
import Firebase

protocol ShareLocation {
    func shared(loc: String)
}

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var location: ShareLocation!
    var currentCity: String = ""
    
    private var tableView = UITableView()
    private let indentifire = "Cell"
    private var array = ["Профиль", "Местоположение", "Политика конфиденциальности", "Пользовательское соглашения"]
    
    private let customTitle: UILabel = {
        let title = UILabel()
        title.text = "НАСТРОЙКИ"
        title.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        title.textColor = Color.mainTextColor
        return title
    }()
    
    private let locationLabel: UILabel = {
        let text = UILabel()
        Service.getLocation(completion: { location in
            text.text = location ?? "Не выбрано"
        })
        text.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        text.textAlignment = .right
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 20)
        return text
    }()
    
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выход", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.addTarget(self, action: #selector(tapExit), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func tapExit() {
        presentSimpleAlert(title: "Выход", message: "Вы уверены, что хотите выйти из акканута")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.mainBackgroundColor
        setupView()
        createTable()

        view.addSubview(locationLabel)
        
        locationLabel.snp.makeConstraints { make in
            
            
            if view.frame.height == 667 {
            // iiPhone 6,7,8 Plus,SE
                make.top.equalToSuperview().inset(view.frame.height / 2.95)
            } else if view.frame.height == 932 {
            // iPhone 14 Pro Max
                make.top.equalToSuperview().inset(view.frame.height / 4.2)
            } else if view.frame.height == 926 {
            // iPhone 12 Pro Max
                make.top.equalToSuperview().inset(view.frame.height / 4.1)
            } else if view.frame.height == 852 {
            // iPhone 14 Pro
                make.top.equalToSuperview().inset(view.frame.height / 3.8)
            } else if view.frame.height == 844 {
            // iPhone 14
                make.top.equalToSuperview().inset(view.frame.height / 3.75)
            } else if view.frame.height == 896 {
            // iPhone 11,XR,XS Max,11 Pro Max
                make.top.equalToSuperview().inset(view.frame.height / 3.95)
            } else if view.frame.height == 812 {
            // iPhone X,XS,11 Pro,12 mini, 13 mini
                make.top.equalToSuperview().inset(view.frame.height / 3.6)
            } else if view.frame.height == 736 {
            // iPhone 6,7,8 Plus
                make.top.equalToSuperview().inset(view.frame.height / 3.3)
            } else if view.frame.height == 568 {
            // iPhone 5,6
            }
            
            make.height.equalTo(50)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    private func setupView() {
                
        view.addSubview(customTitle)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = Color.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Color.mainTextColor!]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = Color.mainTextColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        customTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(80)
        }
    }
    
    private func createTable() {
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.bounces = false
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(160)
            make.left.right.equalToSuperview()
            make.height.equalTo(240)
        }
        
        view.addSubview(exitButton)
        
        exitButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 4
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let name = array[indexPath.row]
        cell.textLabel?.text = "\(name)"

        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = Color.mainBackgroundColor
        cell.textLabel?.textColor = Color.mainTextColor
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if array[indexPath.row] == "Профиль" {
            let profileSetting = ProfileSettingViewController()
            navigationController?.pushViewController(profileSetting, animated: true)
        } else if array[indexPath.row] == "Местоположение" {
            let profileSetting = LocationSettingViewController()
            navigationController?.pushViewController(profileSetting, animated: true)
        } else if array[indexPath.row] == "Политика конфиденциальности" {
            let profileSetting = PrivacyPolicyViewController()
            navigationController?.pushViewController(profileSetting, animated: true)
        } else if array[indexPath.row] == "Пользовательское соглашения" {
            let profileSetting = UserAgreementViewConttroller()
            navigationController?.pushViewController(profileSetting, animated: true)
        }
    }
}

extension SettingViewController {
    
    func presentSimpleAlert(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            
            do {
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 15, *)
struct Setting: PreviewProvider {
    
    static var previews: some View {
        
        SettingViewController().toPreview()
    }
}
#endif
