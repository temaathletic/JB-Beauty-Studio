//
//  ViewController3.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 03.01.2023.
//

import UIKit

class ViewController3: UIViewController {
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "welcomePic3")
        image.contentMode = .scaleToFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(image)
        view.backgroundColor = .white
        
        image.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
