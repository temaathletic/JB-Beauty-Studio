//
//  CustomTextField.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 27.02.2023.
//

import UIKit
import SnapKit

final class CustomTextField: UITextField {
    
    private lazy var innerShadow: CALayer = {
            let innerShadow = CALayer()
            layer.addSublayer(innerShadow)
            return innerShadow
        }()
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    
    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
        applyDesign()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func applyDesign() {
            innerShadow.frame = bounds

            // Shadow path (1pt ring around bounds)
            let radius = self.frame.size.height/2
            let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -1, dy:-1), cornerRadius:radius)
            let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:radius).reversing()


            path.append(cutout)
            innerShadow.shadowPath = path.cgPath
            innerShadow.masksToBounds = true
            // Shadow properties
            innerShadow.shadowColor = UIColor.darkGray.cgColor
            innerShadow.shadowOffset = CGSize(width: 0, height: 2)
            innerShadow.shadowOpacity = 0.5
            innerShadow.shadowRadius = 2
            innerShadow.cornerRadius = self.frame.size.height/2
        }
    
    private func setupTextField(placeholder: String) {
        
        textColor = .black
        font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        
        layer.cornerRadius = 20
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 15, height: 15)
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}

