//
//  PriceViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit

class PriceViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.backgroundColor = .black
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "bgForPriceVC")!)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIStackView = {
        let content = UIStackView()
        content.axis = .horizontal
        content.spacing = 15
        return content
    }()
    
    private let phForImage1: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private let image1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "PriceList")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let phForImage2: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private let image2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "FaceBotomeKey")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let phForImage3: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private let image3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "CounterPlastick")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let phForImage4: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private let image4: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Boulinoterapiya")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(phForImage1)
        contentView.addArrangedSubview(phForImage2)
        contentView.addArrangedSubview(phForImage3)
        contentView.addArrangedSubview(phForImage4)
        phForImage1.addSubview(image1)
        phForImage2.addSubview(image2)
        phForImage3.addSubview(image3)
        phForImage4.addSubview(image4)

        
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalTo(scrollView).inset(15)
            make.centerY.equalTo(scrollView)
        }
        
        phForImage1.snp.makeConstraints { make in
            make.left.equalTo(contentView)
            make.height.equalTo(750)
            make.bottom.equalTo(contentView)
            make.width.equalTo(view.frame.width / 1.2)
        }
        
        image1.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(phForImage1).inset(5)
        }
        
        phForImage2.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.width.equalTo(view.frame.width / 1.2)
        }
        
        image2.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(phForImage2).inset(5)
        }
        
        phForImage3.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.width.equalTo(view.frame.width / 1.2)
        }
        
        image3.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(phForImage3).inset(5)
        }
        
        phForImage4.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.width.equalTo(view.frame.width / 1.2)
        }
        
        image4.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(phForImage4).inset(5)
        }
    }
}

