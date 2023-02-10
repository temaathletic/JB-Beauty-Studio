//
//  ViewController2.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 03.01.2023.
//

import UIKit

class ViewController2: UIViewController {
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "welcomePic2")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(image)
        view.backgroundColor = .white
        
        image.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(70)
            
        }
    }
    
}
