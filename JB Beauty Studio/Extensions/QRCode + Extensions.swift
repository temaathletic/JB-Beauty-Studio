//
//  QRCode + Extensions.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 12.02.2023.
//
import UIKit
import SnapKit
import Combine

extension UIImage {
    
    /// place the imageView inside a container view
    /// - parameter superView: the containerView that you want to place the Image inside
    /// - parameter width: width of imageView, if you opt to not give the value, it will take default value of 100
    /// - parameter height: height of imageView, if you opt to not give the value, it will take default value of 30
    func addToCenter(of superView: UIView, width: CGFloat = 60, height: CGFloat = 60) {
        let overlayImageView = UIImageView(image: self)
        superView.layer.cornerRadius = 30
        overlayImageView.layer.cornerRadius = 30
        superView.clipsToBounds = true
        overlayImageView.clipsToBounds = true
        
        overlayImageView.contentMode = .scaleAspectFit
        superView.addSubview(overlayImageView)
        
        overlayImageView.snp.makeConstraints { make in
            make.center.equalTo(superView)
            make.size.equalTo(60)
        }
    }
}
