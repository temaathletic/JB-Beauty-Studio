//
//  FeedBackViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 20.01.2023.
//

import UIKit
import SnapKit

class FeedBackViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let sView = UIScrollView()
        sView.bounces = false
        sView.showsVerticalScrollIndicator = false
        return sView
    }()
    
    private let contentView: UIStackView = {
        let cView = UIStackView()
        cView.spacing = 10
        cView.backgroundColor = .white
        cView.layer.cornerRadius = 25
        cView.axis = .vertical
        return cView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgForPriceVC")!)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        createNewFeedBack(imageSet: "ava1", textSet: "Высший класс, давольна!", name: "Эльвира")
        createNewFeedBack(imageSet: "ava2", textSet: "Огромное спасибо, приду еще.", name: "Елена")
        createNewFeedBack(imageSet: "ava3", textSet: "Рекомендую! Очень довольна косметологом.", name: "Таня")
        createNewFeedBack(imageSet: "ava4", textSet: "Очень благодарна Юлии за чудесные губы.", name: "Света")
        createNewFeedBack(imageSet: "ava5", textSet: "Рекомендую! Очень довольна косметологом.", name: "Катя")
        createNewFeedBack(imageSet: "ava6", textSet: "Рекомендую! Очень довольна косметологом.", name: "Екатерина")
        createNewFeedBack(imageSet: "ava3", textSet: "Рекомендую! Очень довольна косметологом.", name: "Алина")
        
        scrollView.snp.makeConstraints { make in
            make.width.centerX.height.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.left.right.equalTo(scrollView).inset(15)
            make.bottom.equalTo(scrollView)
            make.top.equalTo(scrollView).inset(60)
        }
    }
    
    private func createNewFeedBack(imageSet: String, textSet: String, name: String) {
        
        let line: UIView = {
            let line = UIView()
            line.backgroundColor = #colorLiteral(red: 0.9079676867, green: 0.907967627, blue: 0.907967627, alpha: 0.6901515935)
            return line
        }()
        
        let placeholder: UIView = {
            let place = UIView()
            place.backgroundColor = .none
            place.layer.cornerRadius = 15
            return place
        }()
        
        let textName: UILabel = {
            let text = UILabel()
            text.text = name
            text.textColor = .black
            text.font = UIFont(name: "GlacialIndifference-Bold", size: 15)
            text.numberOfLines = 0
            return text
        }()
        
        let text: UILabel = {
            let text = UILabel()
            text.text = textSet
            text.textColor = .black
            text.font = UIFont(name: "GlacialIndifference-Regular", size: 15)
            text.numberOfLines = 0
            return text
        }()
        
        let avaBorder: UIView = {
            let border = UIView()
            border.layer.cornerRadius = 35
            border.layer.borderWidth = 1
            border.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            return border
        }()
        
        let ava: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: imageSet)
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.layer.cornerRadius = 33
            return image
        }()
        
        contentView.addArrangedSubview(placeholder)
        placeholder.addSubview(text)
        placeholder.addSubview(avaBorder)
        placeholder.addSubview(textName)
        placeholder.addSubview(line)
        avaBorder.addSubview(ava)
        
        placeholder.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.height.equalTo(100)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalTo(placeholder).inset(10)
            make.height.equalTo(1)
            make.bottom.equalTo(placeholder.snp.bottom)
        }
    
        
        textName.snp.makeConstraints { make in
            make.top.equalTo(placeholder).inset(22)
            make.left.equalTo(avaBorder.snp.right).inset(-15)
        }
        
        text.snp.makeConstraints { make in
            make.left.equalTo(avaBorder.snp.right).inset(-15)
            make.top.equalTo(textName.snp.bottom)
            make.right.equalTo(placeholder).inset(5)
        }
        
        avaBorder.snp.makeConstraints { make in
            make.left.equalTo(placeholder).inset(10)
            make.centerY.equalTo(placeholder)
            make.size.equalTo(70)
        }
        
        ava.snp.makeConstraints { make in
            make.center.equalTo(avaBorder)
            make.size.equalTo(66)
        }
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct FeedBackVCPreview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        FeedBackViewController().toPreview()
    }
}
#endif
