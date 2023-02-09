//
//  PopUpForCartViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 01.02.2023.
//

import UIKit
import SnapKit

class PopUpForCartViewController: UIViewController {
    
    let popUpView: UIView = {
        let placeholder = UIView()
        placeholder.layer.cornerRadius = 35
        return placeholder
    }()
    
    private let nameWhatsApp: UILabel = {
        let name = UILabel()
        name.text = "Написать"
        name.font = UIFont(name: "GlacialIndifference-Bold", size: 15)
        name.textColor = Color.mainTextColor
        name.numberOfLines = 0
        name.textAlignment = .center
        return name
    }()
    
    private let nameCall: UILabel = {
        let name = UILabel()
        name.text = "Позвонить"
        name.font = UIFont(name: "GlacialIndifference-Bold", size: 15)
        name.textColor = Color.mainTextColor
        name.numberOfLines = 0
        name.textAlignment = .center
        return name
    }()
    
    private lazy var whatsAppIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "whatsapp")
        icon.contentMode = .scaleAspectFill
        icon.isUserInteractionEnabled = true
        icon.addGestureRecognizer(gestureForWhatsApp)
        return icon
    }()
    
    private lazy var callIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "phone-call")
        icon.contentMode = .scaleAspectFill
        icon.isUserInteractionEnabled = true
        icon.addGestureRecognizer(gestureForCall)
        return icon
    }()
    
    private lazy var gestureForCall: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapToCall))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var gestureForWhatsApp: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapToWhatsApp))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func blur() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    private func setupView() {
        
        view.backgroundColor = Color.mainBackgroundColorWithOppacity
        popUpView.backgroundColor = Color.mainBackgroundColor
        
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        view.addGestureRecognizer(createTapGestureRecognizer())
        
        view.addSubview(popUpView)
        popUpView.addSubview(whatsAppIcon)
        popUpView.addSubview(nameWhatsApp)
        popUpView.addSubview(callIcon)
        popUpView.addSubview(nameCall)
        
        popUpView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(350)
        }
        
        whatsAppIcon.snp.makeConstraints { make in
            make.top.equalTo(popUpView).inset(60)
            make.left.equalTo(popUpView).inset(75)
            make.size.equalTo(60)
        }
        
        nameWhatsApp.snp.makeConstraints { make in
            make.top.equalTo(whatsAppIcon.snp.bottom).inset(-10)
            make.centerX.equalTo(whatsAppIcon)
        }
        
        callIcon.snp.makeConstraints { make in
            make.top.equalTo(popUpView).inset(60)
            make.right.equalTo(popUpView).inset(75)
            make.size.equalTo(60)
        }
        
        nameCall.snp.makeConstraints { make in
            make.top.equalTo(callIcon.snp.bottom).inset(-10)
            make.centerX.equalTo(callIcon)
        }
        
    }
    
    @objc private func callPhone(string: String) {
        UIApplication.shared.open(NSURL(string: string)! as URL)
    }
    
    @objc private func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func tapToWhatsApp() {
        animateView(whatsAppIcon)
        openUrl(urlString: "https://wa.me/+79180235043")
    }
    
    @objc func tapToCall() {
        animateView(callIcon)
        callPhone(string: "tel://+79180235043")
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
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
     func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
    }
    
    @objc private func didTouch(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    func createTapGestureRecognizer() -> UITapGestureRecognizer {
        let swipeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        return swipeGestureRecognizer
    }
}

#if DEBUG
import SwiftUI

@available(iOS 15, *)
struct pop: PreviewProvider {
    
    static var previews: some View {

        PopUpForCartViewController().toPreview()
    }
}
#endif
