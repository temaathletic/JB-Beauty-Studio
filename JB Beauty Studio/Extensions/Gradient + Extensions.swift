//
//  Gradient + Extensions.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 14.01.2023.
//

import Foundation
import UIKit

class Gradient: UIButton {
    
    override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = bounds
        }

        private lazy var gradientLayer: CAGradientLayer = {
            let l = CAGradientLayer()
            l.frame = self.bounds
            l.colors = [UIColor.red.cgColor, UIColor.white.cgColor]
            l.startPoint = CGPoint(x: 0, y: 0.5)
            l.endPoint = CGPoint(x: 1, y: 0.5)
            l.cornerRadius = 16
            layer.insertSublayer(l, at: 0)
            return l
        }()
}
