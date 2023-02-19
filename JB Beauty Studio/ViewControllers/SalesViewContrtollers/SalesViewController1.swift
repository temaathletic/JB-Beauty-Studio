//
//  SalesViewController1.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 23.01.2023.
//

import UIKit
import SnapKit

class SalesViewController1: UIViewController {
    
    private let phForImage1: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        Service.downloadImagesForSaleBox(photo: view, name: "SaleBox1MainBack")
        return view
    }()
    
    private let image1: UIImageView = {
        let image = UIImageView()
        Service.downloadImagesForSaleBox(photo: image, name: "SaleBox1MainPic")
        image.layer.cornerRadius = 0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(phForImage1)
        phForImage1.addSubview(image1)
        
        phForImage1.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        image1.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.equalTo(view.frame.height / 1.25)
            make.width.equalTo(view.frame.width / 1)
        }
    }
}
