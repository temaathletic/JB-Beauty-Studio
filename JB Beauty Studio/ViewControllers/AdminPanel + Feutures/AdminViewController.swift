//
//  AdminViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class AdminViewController: UIViewController {
    
    private lazy var turnOnOffButton: UIButton = {
        let button = UIButton()
        button.setTitle("Скрыть ячейки гл. э.", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(mainSwitcher), for: .touchUpInside)
        return button
    }()
    
    private let turnOnOffImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "switch.2")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var reportButton: UIButton = {
        let button = UIButton()
        button.setTitle("Проблемы пользователей", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(report), for: .touchUpInside)
        return button
    }()
    
    private let reportImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "nosign.app.fill")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var saleBoxEnable: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить акции", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saleBoxSwitch), for: .touchUpInside)
        return button
    }()
    
    private let saleBoxImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "lightswitch.on")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var searchPeopleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Найти человека", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(searchPeople), for: .touchUpInside)
        return button
    }()
    
    private let searchPersonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var sessionLog: UIButton = {
        let button = UIButton()
        button.setTitle("Журнал посещений", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(searchSessionLog), for: .touchUpInside)
        return button
    }()
    
    private let sessionLogImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "text.book.closed")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var scanFromCart: UIButton = {
        let button = UIButton()
        button.setTitle("Сканировать из корзины", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(decrimentBonus), for: .touchUpInside)
        return button
    }()
    
    private let scanFromCartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "qrcode.viewfinder")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var decrimentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Списать баллы", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(startScann), for: .touchUpInside)
        return button
    }()
    
    private let decrimentQRCode: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "minus.square")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить баллы", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(incrementBonus), for: .touchUpInside)
        return button
    }()
    
    private let addBonus: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus.square")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var customProcedure: UIButton = {
        let button = UIButton()
        button.setTitle("Расчитать акцию", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(customProcedureAction), for: .touchUpInside)
        return button
    }()
    
    private let customProcedureImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "dollarsign.arrow.circlepath")
        image.tintColor = Color.mainTextColor
        return image
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выход", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapExit), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.mainBackgroundColor
        view.addSubview(turnOnOffButton)
        view.addSubview(reportButton)
        view.addSubview(saleBoxEnable)
        view.addSubview(sessionLog)
        view.addSubview(searchPeopleButton)
        view.addSubview(scanFromCart)
        view.addSubview(exitButton)
        view.addSubview(decrimentButton)
        view.addSubview(customProcedure)
        view.addSubview(addButton)
        turnOnOffButton.addSubview(turnOnOffImage)
        reportButton.addSubview(reportImage)
        saleBoxEnable.addSubview(saleBoxImage)
        sessionLog.addSubview(sessionLogImage)
        addButton.addSubview(addBonus)
        decrimentButton.addSubview(decrimentQRCode)
        scanFromCart.addSubview(scanFromCartImage)
        searchPeopleButton.addSubview(searchPersonImage)
        customProcedure.addSubview(customProcedureImage)
        
        turnOnOffButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.bottom.equalTo(reportButton.snp.top).inset(-10)
        }
        
        turnOnOffImage.snp.makeConstraints { make in
            make.right.equalTo(turnOnOffButton).inset(15)
            make.centerY.equalTo(turnOnOffButton)
            make.size.equalTo(30)
        }
        
        reportButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.bottom.equalTo(saleBoxEnable.snp.top).inset(-10)
        }
        
        reportImage.snp.makeConstraints { make in
            make.right.equalTo(reportButton).inset(15)
            make.centerY.equalTo(reportButton)
            make.size.equalTo(30)
        }
        
        saleBoxEnable.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.bottom.equalTo(sessionLog.snp.top).inset(-10)
        }
        
        saleBoxImage.snp.makeConstraints { make in
            make.right.equalTo(saleBoxEnable).inset(15)
            make.centerY.equalTo(saleBoxEnable)
            make.size.equalTo(30)
        }
        
        sessionLog.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.bottom.equalTo(searchPeopleButton.snp.top).inset(-10)
        }
        
        sessionLogImage.snp.makeConstraints { make in
            make.right.equalTo(sessionLog).inset(15)
            make.centerY.equalTo(sessionLog)
            make.size.equalTo(30)
        }
        
        searchPeopleButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.bottom.equalTo(decrimentButton.snp.top).inset(-10)
        }
        
        decrimentButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.top.equalTo(decrimentButton.snp.bottom).inset(-10)
        }
        
        scanFromCart.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.top.equalTo(addButton.snp.bottom).inset(-10)
        }
        
        searchPersonImage.snp.makeConstraints { make in
            make.right.equalTo(searchPeopleButton).inset(15)
            make.centerY.equalTo(searchPeopleButton)
            make.size.equalTo(30)
        }
        
        decrimentQRCode.snp.makeConstraints { make in
            make.right.equalTo(decrimentButton).inset(15)
            make.centerY.equalTo(decrimentButton)
            make.size.equalTo(30)
        }
        
        addBonus.snp.makeConstraints { make in
            make.right.equalTo(addButton).inset(15)
            make.centerY.equalTo(addButton)
            make.size.equalTo(30)
        }
        
        scanFromCartImage.snp.makeConstraints { make in
            make.right.equalTo(scanFromCart).inset(15)
            make.centerY.equalTo(scanFromCart)
            make.size.equalTo(30)
        }
        
        customProcedure.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.top.equalTo(scanFromCart.snp.bottom).inset(-10)
        }
        
        customProcedureImage.snp.makeConstraints { make in
            make.right.equalTo(customProcedure).inset(15)
            make.centerY.equalTo(customProcedure)
            make.size.equalTo(30)
        }
        
        exitButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}

extension AdminViewController {
    
    @objc private func mainSwitcher() {
        animateView(turnOnOffButton)
        let vc = HidenCellsViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    @objc private func report() {
        animateView(customProcedure)
        let vc = ReportViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    @objc private func customProcedureAction() {
        animateView(customProcedure)
        let vc = ScanVCForCustomSale()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    @objc private func saleBoxSwitch() {
        animateView(saleBoxEnable)
        let scene = SettingSaleBoxViewController()
        scene.modalPresentationStyle = .fullScreen
        present(scene, animated: true)
    }
    
    @objc private func searchSessionLog() {
        animateView(sessionLog)
        modalPresentationStyle = .popover
        present(SearchSessionLogViewController(), animated: true)
    }
    
    @objc private func incrementBonus() {
        animateView(addBonus)
        modalPresentationStyle = .popover
        present(ScanVCFormCartForIncrement(), animated: true)
    }
    
    @objc private func startScann() {
        animateView(decrimentButton)
        modalPresentationStyle = .popover
        present(ScanViewController(), animated: true)
    }
    
    @objc private func searchPeople() {
        animateView(searchPeopleButton)
        let vc = SearchPeopleViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    @objc private func decrimentBonus() {
        animateView(scanFromCart)
        let vc = ScanVCFormCartForDicrement()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    @objc private func tapExit() {
        animateView(exitButton)
        presentSimpleAlert(title: "Выход", message: "Вы уверены, что хотите выйти из акканута")
    }

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
    
    @objc private func animateView(_ viewAnimate: UIView) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations:  {
            viewAnimate.transform = CGAffineTransform(scaleX: 0.55, y: 0.55)
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.4, options: .curveEaseIn) {
                viewAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
