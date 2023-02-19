//
//  ViewController + Extensions.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import SwiftUI

extension UIViewController {
    
    private struct Preview: UIViewControllerRepresentable {
        let viewControoller: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewControoller
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    func showPreview() -> some View {
        Preview(viewControoller: self).edgesIgnoringSafeArea(.all)
    }
}

extension UIViewController {
    
    func createCustomNavBar() {
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    func createCustomTitleView(contactName: String, contactDescription: String, contactImage: String) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 280, height: 41)
        
        
        let imageContact = UIImageView()
        imageContact.image = UIImage(named: contactImage)
        imageContact.layer.cornerRadius = 20
        imageContact.sizeToFit()
        imageContact.layer.masksToBounds = true
        imageContact.frame = CGRect(x: 5, y: 0, width: 40, height: 40)
        view.addSubview(imageContact)
        
        let nameLabel = UILabel()
        nameLabel.text = contactName
        nameLabel.textColor = .white
        nameLabel.frame = CGRect(x: 55, y: 0, width: 220, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 20)

        view.addSubview(nameLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = contactDescription
        descriptionLabel.frame = CGRect(x: 55, y: 21, width: 220, height: 20)
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(descriptionLabel)
        
        return view
    }
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
    
    func createRightButtonForCart(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = Color.mainTextColor
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
    
    func createLeftButtonForCart(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = Color.mainTextColor
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
