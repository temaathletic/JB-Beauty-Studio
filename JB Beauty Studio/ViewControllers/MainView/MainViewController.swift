//
//  MainViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import Combine
import SnapKit
import SideMenu
import FirebaseFirestore
import FirebaseAuth
import Lottie

class MainViewController: UIViewController, DataDelegate {
    
    public var points = 0
    var deleagte: DataDelegate!
    var badgeCountDelegate: Int?
    var lastContentOffset: CGFloat = 0
    
    var menu: SideMenuNavigationController?
    
    private let fireworkController = ClassicFireworkController()
    
    private lazy var placeholderForBonuses: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.addGestureRecognizer(gestureForBonusPointPH)
        return view
    }()
    
    private lazy var gestureForBonusPointPH: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(refresh))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    public lazy var bonusPoint: UILabel = {
        let point = UILabel()
        point.textAlignment = .center
        point.textColor = .white
        point.font = UIFont(name: "GlacialIndifference-Bold", size: 35)
        return point
    }()
    
    private lazy var placeholderForWrittenButton: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return view
    }()
    
    private lazy var textForPHWritten: UILabel = {
        let text = UILabel()
        text.text = "ЗАПИСЬ"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 25)
        text.textAlignment = .left
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return text
    }()
    
    private lazy var telegramButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "telegram"), for: .normal)
        view.addTarget(self, action: #selector(tapTelegram), for: .touchUpInside)
        return view
    }()
    
    private lazy var whatsAppButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "whatsapp"), for: .normal)
        view.addTarget(self, action: #selector(tapWA), for: .touchUpInside)
        return view
    }()
    
    private lazy var instagramButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "instagram"), for: .normal)
        view.addTarget(self, action: #selector(tapInsta), for: .touchUpInside)
        return view
    }()
    
    //MARK: - QRcode Button
    //MARK: - QrCode для списания
    
    private lazy var qrCodeButton: UIView = {
        let button = UIView()
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        button.layer.cornerRadius = 25
        button.addGestureRecognizer(gestureForQR)
        button.isUserInteractionEnabled = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 10
        return button
    }()
    
    private lazy var gestureForQR: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapQR))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var contentForQRCode: UIView = {
        let button = UIView()
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    private lazy var textForQRCodePart1: UILabel = {
        let text = UILabel()
        text.text = "ПРЕДЪЯВИТЕ КАРТУ"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        text.textAlignment = .left
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.numberOfLines = 0
        
        return text
    }()
    
    private lazy var textForQRCodePart2: UILabel = {
        let text = UILabel()
        text.text = "И ПОЛУЧИТЕ БАЛЛЫ"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        text.textAlignment = .left
        text.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.numberOfLines = 0
        
        return text
    }()
    
    private lazy var stickerView: UIImageView = {
        let sticker = UIImageView()
        sticker.image = UIImage(named: "sticker")
        sticker.contentMode = .scaleAspectFit
        return sticker
    }()
    
    //MARK: - HeaderView
    
    private lazy var headerView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "headerViewMain")!)
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        return view
    }()
    
    //MARK: - Main Scroll View
    
    private  var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private  var mainContentView: UIStackView = {
        let content = UIStackView()
        content.axis = .vertical
        content.spacing = 25
        content.isUserInteractionEnabled = true
        return content
    }()
    
    //MARK: - ScrollView 1
    
    private lazy var scrollView1: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceHorizontal = true
        Service.getCellsSwitchStatus("ScrollView 1") { value in
            let answer = value ?? true
            view.isHidden = answer
        }
        return view
    }()
    
    let scrollViewContainer1: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 15
        view.alignment = .center
        return view
    }()
    
    private lazy var boxesNew1: UIView = {
        let box = UIView()
        box.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        box.layer.cornerRadius = 15
        box.addGestureRecognizer(gestureForBoxNew1)
        box.isUserInteractionEnabled = true
        box.layer.shadowColor = UIColor.black.cgColor
        box.layer.shadowOffset = CGSize(width: 0, height: 7)
        box.layer.shadowOpacity = 1
        box.layer.shadowRadius = 10
        Service.getCellsSwitchStatus("Cell 4") { value in
            let answer = value ?? true
            box.isHidden = answer
        }
        return box
    }()
    
    private lazy var gestureForBoxNew1: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapBoxNew1))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var textNews1: UILabel = {
        let text = UILabel()
        text.text = "Прайс"
        text.textAlignment = .center
        text.textColor = Color.mainRedColor
        text.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return text
    }()
    
    private lazy var textNewsDesciption1: UILabel = {
        let text = UILabel()
        text.text = "Посмотреть бесконтактный прайс"
        text.textAlignment = .center
        text.numberOfLines = 0
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 17, weight: .light)
        return text
    }()
    
    private lazy var boxesNew2: UIView = {
        let box = UIView()
        box.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        box.layer.cornerRadius = 15
        box.addGestureRecognizer(gestureForBoxNew2)
        box.isUserInteractionEnabled = true
        box.layer.shadowColor = UIColor.black.cgColor
        box.layer.shadowOffset = CGSize(width: 0, height: 10)
        box.layer.shadowOpacity = 1
        box.layer.shadowRadius = 10
        Service.getCellsSwitchStatus("Cell 5") { value in
            let answer = value ?? true
            box.isHidden = answer
        }
        return box
    }()
    
    private lazy var gestureForBoxNew2: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapBoxNew2))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var textNews2: UILabel = {
        let text = UILabel()
        text.text = "Условия"
        text.textAlignment = .center
        text.textColor = Color.mainRedColor
        text.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return text
    }()
    
    private lazy var textNewsDesciption2: UILabel = {
        let text = UILabel()
        text.text = "Программа лояльности"
        text.textAlignment = .center
        text.numberOfLines = 0
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 17, weight: .light)
        return text
    }()
    
    private lazy var boxesNew3: UIView = {
        let box = UIView()
        box.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        box.layer.cornerRadius = 15
        box.addGestureRecognizer(gestureForBoxNew3)
        box.isUserInteractionEnabled = true
        box.layer.shadowColor = UIColor.black.cgColor
        box.layer.shadowOffset = CGSize(width: 0, height: 10)
        box.layer.shadowOpacity = 1
        box.layer.shadowRadius = 10
        Service.getCellsSwitchStatus("Cell 6") { value in
            let answer = value ?? true
            box.isHidden = answer
        }
        return box
    }()
    
    private lazy var gestureForBoxNew3: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapBoxNew3))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var textNews3: UILabel = {
        let text = UILabel()
        text.text = "Отзыв"
        text.textAlignment = .center
        text.textColor = Color.mainRedColor
        text.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return text
    }()
    
    private lazy var textNewsDesciption3: UILabel = {
        let text = UILabel()
        text.text = "Оцените свой визит"
        text.textAlignment = .center
        text.numberOfLines = 0
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 17, weight: .light)
        return text
    }()
    
    private lazy var boxesNew4: UIView = {
        let box = UIView()
        box.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        box.layer.cornerRadius = 15
        box.addGestureRecognizer(gestureForBoxNew4)
        box.isUserInteractionEnabled = true
        box.layer.shadowColor = UIColor.black.cgColor
        box.layer.shadowOffset = CGSize(width: 0, height: 10)
        box.layer.shadowOpacity = 1
        box.layer.shadowRadius = 10
        Service.getCellsSwitchStatus("Cell 7") { value in
            let answer = value ?? true
            box.isHidden = answer
        }
        return box
    }()
    
    private lazy var gestureForBoxNew4: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapBoxNew4))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var textNews4: UILabel = {
        let text = UILabel()
        text.text = "Обучение"
        text.textAlignment = .center
        text.textColor = Color.mainRedColor
        text.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return text
    }()
    
    private lazy var textNewsDesciption4: UILabel = {
        let text = UILabel()
        text.text = "Обучение косметологии"
        text.textAlignment = .center
        text.numberOfLines = 0
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 17, weight: .light)
        return text
    }()
    
    //MARK: - ScrollView 2
    
    private lazy var scrollView2: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        Service.getCellsSwitchStatus("ScrollView 2") { value in
            let answer = value ?? true
            view.isHidden = answer
        }
        return view
    }()
    
    let scrollViewContainer2: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 25
        return view
    }()
    
    private lazy var salesText: UILabel = {
        let text = UILabel()
        text.text = "Акции"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 23)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        Service.getCellsSwitchStatus("ScrollView 2") { value in
            let answer = value ?? true
            text.isHidden = answer
        }
        return text
    }()
    
    //MARK: - Placeholders For Bonus
    
    private lazy var placeholderForBonusText1: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 20
        view.addGestureRecognizer(gestureForPHBonus1)
        Service.getCellsSwitchStatus("Cell 1") { value in
            let answer = value ?? false
            view.isHidden = answer
        }
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        return view
    }()
    
    private lazy var gestureForPHBonus1: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPHBonus1))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    public lazy var picForPH1: UIImageView = {
        let image = UIImageView()
        Service.downloadImagesForSaleBox(photo: image, name: "SaleBox1")
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var placeholderForBonusText2: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 20
        Service.getCellsSwitchStatus("Cell 2") { value in
            let answer = value ?? false
            view.isHidden = answer
        }
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        view.addGestureRecognizer(gestureForPHBonus2)
        return view
    }()
    
    private lazy var gestureForPHBonus2: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPHBonus2))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    public lazy var picForPH2: UIImageView = {
        let image = UIImageView()
        Service.downloadImagesForSaleBox(photo: image, name: "SaleBox2")
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var placeholderForBonusText3: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 20
        Service.getCellsSwitchStatus("Cell 3") { value in
            let answer = value ?? false
            view.isHidden = answer
        }
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        view.addGestureRecognizer(gestureForPHBonus3)
        return view
    }()
    
    private lazy var gestureForPHBonus3: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPHBonus3))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    public lazy var picForPH3: UIImageView = {
        let image = UIImageView()
        Service.downloadImagesForSaleBox(photo: image, name: "SaleBox3")
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //MARK: - Bonuses
    
    private let placeholderForButtonPrice: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var buttonPHForPrice: UIView = {
        let view = UIView()
        view.backgroundColor = Color.mainRedColor
        view.layer.cornerRadius = 15
        view.addGestureRecognizer(gestureForButtonPrice)
        view.isUserInteractionEnabled = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        return view
    }()
    
    private lazy var gestureForButtonPrice: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPOF))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private let textPHPricePart1: UILabel = {
        let text = UILabel()
        text.text = "ВЫБРАТЬ ПРОЦЕДУРУ"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return text
    }()
    
    private lazy var scrollViewForBonusOfPoint: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0)
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        Service.getCellsSwitchStatus("ScrollView 3") { value in
            let answer = value ?? true
            view.isHidden = answer
        }
        return view
    }()
    
    private lazy var placeholderForBonusOfPoint: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0)
        view.spacing = 35
        view.axis = .vertical
        view.addArrangedSubview(bonusText)
        view.addArrangedSubview(placeholderForText1)
        placeholderForText1.addSubview(text1)
        placeholderForText1.addSubview(imageForText1)
        view.addArrangedSubview(placeholderForText2)
        placeholderForText2.addSubview(text2)
        placeholderForText2.addSubview(imageForText2)
        view.addArrangedSubview(placeholderForText3)
        placeholderForText3.addSubview(text3)
        placeholderForText3.addSubview(imageForText3)
        view.addArrangedSubview(placeholderForText4)
        placeholderForText4.addSubview(text4)
        placeholderForText4.addSubview(imageForText4)
        return view
    }()
    
    private lazy var bonusText: UILabel = {
        let text = UILabel()
        text.text = "Подарки за баллы"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 21)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        Service.getCellsSwitchStatus("ScrollView 3") { value in
            let answer = value ?? true
            text.isHidden = answer
        }
        return text
    }()
    
    private lazy var text1: UILabel = {
        let text = UILabel()
        text.text = "Контурная пластика"
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 16)
        text.textAlignment = .center
        return text
    }()
    
    private lazy var placeholderForText1: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 15
        view.addGestureRecognizer(gestureForText1)
        view.isUserInteractionEnabled = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        Service.getCellsSwitchStatus("Cell 8") { value in
            let answer = value ?? true
            view.isHidden = answer
        }
        return view
    }()
    
    private lazy var gestureForText1: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPHForText1))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var imageForText1: UIImageView = {
        let image = UIImageView(image: UIImage(named: "1")!)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var text2: UILabel = {
        let text = UILabel()
        text.text = "Ботулинотерапия"
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 16)
        text.textAlignment = .center
        return text
    }()
    
    private lazy var placeholderForText2: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 15
        view.addGestureRecognizer(gestureForText2)
        view.isUserInteractionEnabled = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        Service.getCellsSwitchStatus("Cell 9") { value in
            let answer = value ?? true
            view.isHidden = answer
        }
        return view
    }()
    
    private lazy var gestureForText2: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPHForText2))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var imageForText2: UIImageView = {
        let image = UIImageView(image: UIImage(named: "2")!)
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private lazy var text3: UILabel = {
        let text = UILabel()
        text.text = "Процедуры восстановления"
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 16)
        text.textAlignment = .center
        return text
    }()
    
    private lazy var placeholderForText3: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 15
        view.addGestureRecognizer(gestureForText3)
        view.isUserInteractionEnabled = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        Service.getCellsSwitchStatus("Cell 10") { value in
            let answer = value ?? true
            view.isHidden = answer
        }
        return view
    }()
    
    private lazy var gestureForText3: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPHForText3))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var imageForText3: UIImageView = {
        let image = UIImageView(image: UIImage(named: "3")!)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var text4: UILabel = {
        let text = UILabel()
        text.text = "Мерч"
        text.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 16)
        text.textAlignment = .center
        return text
    }()
    
    private lazy var placeholderForText4: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 15
        view.addGestureRecognizer(gestureForText4)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        Service.getCellsSwitchStatus("Cell 11") { value in
            let answer = value ?? true
            view.isHidden = answer
        }
        return view
    }()
    
    private lazy var gestureForText4: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tapPHForText4))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var imageForText4: UIImageView = {
        let image = UIImageView(image: UIImage(named: "4")!)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //MARK: - Contact Buttons
    
    private lazy var phForContactButton: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var textForCall: UILabel = {
        let text = UILabel()
        text.textColor = Color.mainTextColor
        text.text = "Позвонить"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 12)
        return text
    }()
    
    private lazy var imageForCall: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Call")!)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(gestureForButton1)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var gestureForButton1: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(callTapped))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var textForInstagram: UILabel = {
        let text = UILabel()
        text.textColor = Color.mainTextColor
        text.text = "Instagram"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 12)
        return text
    }()
    
    private lazy var imageForInstagram: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Insta")!)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.addGestureRecognizer(gestureForButton2)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var gestureForButton2: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(InstaTapped))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private lazy var textForLocation: UILabel = {
        let text = UILabel()
        text.textColor = Color.mainTextColor
        text.text = "Студии"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 12)
        return text
    }()
    
    private lazy var imageForLocation: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Location")!)
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        image.addGestureRecognizer(gestureForButton3)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var gestureForButton3: UITapGestureRecognizer = {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(LocationTapped))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        return tapped
    }()
    
    private let background: UIImageView = {
        let background = UIImageView()
        background.image = UIImage(named: "MainBG")
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Service.getBonusPoint { bonusPoint in
            self.bonusPoint.text = "\(bonusPoint ?? 0) баллов"
        }
        
        let vc = ShopCartViewController()
        
        let shopButton = createCustomButton(imageName: "cart.fill", selector: #selector(shopBtn))
        vc.getAllItem()
        shopButton.addBadge(vc.myOrder.count, withOffset: CGPoint(x: -35, y: -3), andColor: .systemRed, andFilled: true)
        navigationItem.rightBarButtonItem = shopButton
    }
    
    //MARK: - Setup View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupSideMenu()
        setupView()
    }
    
    //MARK: - SetupView Swtting's
    
    private func setupView() {
        
        Service.getBonusPoint { bonusPoint in
            self.bonusPoint.text = "\(bonusPoint ?? 0) баллов"
        }
        
        getRealTimeBonus2()

        view.addSubview(background)
        
        view.addSubview(mainScrollView)
        mainScrollView.delegate = self
        mainScrollView.contentInsetAdjustmentBehavior = .never
        mainScrollView.addSubview(mainContentView)
        
        mainContentView.addArrangedSubview(headerView)
        mainContentView.addArrangedSubview(qrCodeButton)
        mainContentView.addArrangedSubview(salesText)
        mainContentView.addArrangedSubview(scrollView2)
        mainContentView.addArrangedSubview(scrollView1)
        mainContentView.addArrangedSubview(placeholderForButtonPrice)
        placeholderForButtonPrice.addSubview(buttonPHForPrice)
        placeholderForButtonPrice.addSubview(textPHPricePart1)
        mainContentView.addArrangedSubview(scrollViewForBonusOfPoint)
        scrollViewForBonusOfPoint.addSubview(placeholderForBonusOfPoint)
        mainContentView.addArrangedSubview(phForContactButton)
        
        headerView.addSubview(placeholderForWrittenButton)
        headerView.addSubview(placeholderForBonuses)
        placeholderForBonuses.addSubview(bonusPoint)
        placeholderForWrittenButton.addSubview(telegramButton)
        placeholderForWrittenButton.addSubview(whatsAppButton)
        placeholderForWrittenButton.addSubview(instagramButton)
        placeholderForWrittenButton.addSubview(textForPHWritten)
        
        qrCodeButton.addSubview(contentForQRCode)
        contentForQRCode.addSubview(textForQRCodePart1)
        contentForQRCode.addSubview(textForQRCodePart2)
        contentForQRCode.addSubview(stickerView)
        
        scrollView1.addSubview(scrollViewContainer1)
        
        scrollViewContainer1.addArrangedSubview(boxesNew1)
        scrollViewContainer1.addArrangedSubview(boxesNew2)
        scrollViewContainer1.addArrangedSubview(boxesNew3)
        scrollViewContainer1.addArrangedSubview(boxesNew4)
        
        boxesNew1.addSubview(textNews1)
        boxesNew2.addSubview(textNews2)
        boxesNew3.addSubview(textNews3)
        boxesNew4.addSubview(textNews4)
        
        boxesNew1.addSubview(textNewsDesciption1)
        boxesNew2.addSubview(textNewsDesciption2)
        boxesNew3.addSubview(textNewsDesciption3)
        boxesNew4.addSubview(textNewsDesciption4)
        
        
        scrollView2.addSubview(scrollViewContainer2)
        scrollViewContainer2.addArrangedSubview(placeholderForBonusText1)
        scrollViewContainer2.addArrangedSubview(placeholderForBonusText2)
        scrollViewContainer2.addArrangedSubview(placeholderForBonusText3)
        
        placeholderForBonusText1.addSubview(picForPH1)
        placeholderForBonusText2.addSubview(picForPH2)
        placeholderForBonusText3.addSubview(picForPH3)
        
        phForContactButton.addSubview(imageForCall)
        phForContactButton.addSubview(imageForInstagram)
        phForContactButton.addSubview(imageForLocation)
        phForContactButton.addSubview(textForCall)
        phForContactButton.addSubview(textForInstagram)
        phForContactButton.addSubview(textForLocation)
        
        background.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(500)
        }
        
        boxesNew1.snp.makeConstraints { make in
            make.centerY.equalTo(scrollViewContainer1)
            make.height.equalTo(130)
            make.width.equalTo(180)
        }
        
        textNews1.snp.makeConstraints { make in
            make.top.equalTo(boxesNew1).inset(10)
            make.centerX.equalTo(boxesNew1)
        }
        
        textNewsDesciption1.snp.makeConstraints { make in
            make.top.equalTo(textNews1.snp.bottom).offset(8)
            make.left.right.equalTo(boxesNew1).inset(5)
        }
        
        boxesNew2.snp.makeConstraints { make in
            make.left.equalTo(boxesNew1.snp.right).offset(15)
            make.height.equalTo(130)
            make.width.equalTo(180)
        }
        
        textNews2.snp.makeConstraints { make in
            make.top.equalTo(boxesNew2).inset(10)
            make.centerX.equalTo(boxesNew2)
        }
        
        textNewsDesciption2.snp.makeConstraints { make in
            make.top.equalTo(textNews2.snp.bottom).offset(8)
            make.left.right.equalTo(boxesNew2).inset(5)
        }
        
        boxesNew3.snp.makeConstraints { make in
            make.left.equalTo(boxesNew2.snp.right).offset(15)
            make.height.equalTo(130)
            make.width.equalTo(180)
        }
        
        textNews3.snp.makeConstraints { make in
            make.top.equalTo(boxesNew3).inset(10)
            make.centerX.equalTo(boxesNew3)
        }
        
        textNewsDesciption3.snp.makeConstraints { make in
            make.top.equalTo(textNews3.snp.bottom).offset(8)
            make.left.right.equalTo(boxesNew3).inset(5)
        }
        
        boxesNew4.snp.makeConstraints { make in
            make.left.equalTo(boxesNew3.snp.right).offset(15)
            make.height.equalTo(130)
            make.width.equalTo(180)
        }
        
        textNews4.snp.makeConstraints { make in
            make.top.equalTo(boxesNew4).inset(10)
            make.centerX.equalTo(boxesNew4)
        }
        
        textNewsDesciption4.snp.makeConstraints { make in
            make.top.equalTo(textNews4.snp.bottom).offset(8)
            make.left.right.equalTo(boxesNew4).inset(5)
        }
        
        placeholderForButtonPrice.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.right.equalTo(mainContentView)
        }
        
        textPHPricePart1.snp.makeConstraints { make in
            make.center.equalTo(buttonPHForPrice)
        }
        
        buttonPHForPrice.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.right.equalTo(placeholderForButtonPrice).inset(20)
        }
        
        scrollViewForBonusOfPoint.snp.makeConstraints { make in
            make.top.equalTo(buttonPHForPrice.snp.bottom).inset(-25)
            make.bottom.equalTo(phForContactButton.snp.top).inset(-25)
        }
        
        placeholderForBonusOfPoint.snp.makeConstraints { make in
            make.top.equalTo(scrollViewForBonusOfPoint)
            make.centerX.equalTo(scrollViewForBonusOfPoint)
            make.width.equalTo(view.frame.width / 1.15)
        }
        
        placeholderForText1.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        text1.snp.makeConstraints { make in
            make.centerY.equalTo(placeholderForText1)
            make.left.equalTo(placeholderForText1).inset(20)
        }
        
        imageForText1.snp.makeConstraints { make in
            make.right.equalTo(placeholderForText1).inset(15)
            make.bottom.equalTo(placeholderForText1).inset(-10)
            make.size.equalTo(75)
        }
        
        placeholderForText2.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        text2.snp.makeConstraints { make in
            make.centerY.equalTo(placeholderForText2)
            make.left.equalTo(placeholderForText2).inset(20)
        }
        
        imageForText2.snp.makeConstraints { make in
            make.right.equalTo(placeholderForText2).inset(15)
            make.bottom.equalTo(placeholderForText2).inset(-10)
            make.size.equalTo(70)
        }
        
        placeholderForText3.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        imageForText3.snp.makeConstraints { make in
            make.right.equalTo(placeholderForText3).inset(15)
            make.bottom.equalTo(placeholderForText3).inset(-10)
            make.size.equalTo(70)
        }
        
        text3.snp.makeConstraints { make in
            make.centerY.equalTo(placeholderForText3)
            make.left.equalTo(placeholderForText3).inset(20)
        }
        
        placeholderForText4.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        text4.snp.makeConstraints { make in
            make.centerY.equalTo(placeholderForText4)
            make.left.equalTo(placeholderForText4).inset(20)
        }
        
        imageForText4.snp.makeConstraints { make in
            make.right.equalTo(placeholderForText4).inset(15)
            make.centerY.equalTo(placeholderForText4)
            make.size.equalTo(150)
        }
        
        phForContactButton.snp.makeConstraints { make in
            make.top.equalTo(placeholderForBonusOfPoint.snp.bottom).inset(-25)
            make.height.equalTo(80)
        }
        
        imageForCall.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(phForContactButton)
            make.centerX.equalTo(textForCall)
        }
        
        textForCall.snp.makeConstraints { make in
            make.top.equalTo(imageForCall.snp.bottom).inset(-10)
            make.right.equalTo(imageForInstagram.snp.left).inset(-40)
        }
        
        imageForInstagram.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(phForContactButton)
            make.centerX.equalTo(textForInstagram)
        }
        
        textForInstagram.snp.makeConstraints { make in
            make.centerX.equalTo(phForContactButton)
            make.top.equalTo(imageForInstagram.snp.bottom).inset(-10)
        }
        
        imageForLocation.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(phForContactButton)
            make.centerX.equalTo(textForLocation)
        }
        
        textForLocation.snp.makeConstraints { make in
            make.top.equalTo(imageForLocation.snp.bottom).inset(-10)
            make.left.equalTo(imageForInstagram.snp.right).inset(-40)
        }
        
        //MARK: - ScrollView 1 Constraints
        
        scrollView1.snp.makeConstraints { make in
            make.left.right.equalTo(mainContentView)
            make.height.equalTo(180)
        }
        
        scrollViewContainer1.snp.makeConstraints { make in
            make.left.right.equalTo(scrollView1).inset(20)
            make.top.bottom.equalTo(scrollView1)
        }
        
        //MARK: - ScrollView 2 Constraints
        
        scrollView2.snp.makeConstraints { make in
            make.left.right.equalTo(mainContentView)
            make.height.equalTo(210)
        }
        
        scrollViewContainer2.snp.makeConstraints { make in
            make.left.right.equalTo(scrollView2).inset(20)
            make.top.equalTo(scrollView2)
        }
        
        salesText.snp.makeConstraints { make in
            make.left.equalTo(mainContentView)
        }
        
        placeholderForBonusText1.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.width.equalTo(view.frame.width / 1.1)
        }
        
        picForPH1.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(placeholderForBonusText1)
        }
        
        placeholderForBonusText2.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.width.equalTo(view.frame.width / 1.1)
        }
        
        picForPH2.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(placeholderForBonusText2)
        }
        
        placeholderForBonusText3.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.width.equalTo(view.frame.width / 1.1)
        }
        
        picForPH3.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(placeholderForBonusText3)
        }
        
        qrCodeButton.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(25)
            make.height.equalTo(125)
        }
        
        contentForQRCode.snp.makeConstraints { make in
            make.left.right.equalTo(qrCodeButton).inset(20)
            make.centerY.equalTo(qrCodeButton)
            make.height.equalTo(125)
        }
        
        stickerView.snp.makeConstraints { make in
            make.right.equalTo(contentForQRCode)
            make.bottom.equalTo(contentForQRCode)
            make.size.equalTo(140)
        }
        
        textForQRCodePart1.snp.makeConstraints { make in
            make.left.equalTo(contentForQRCode).inset(20)
            make.top.equalTo(contentForQRCode).inset(35)
        }
        
        textForQRCodePart2.snp.makeConstraints { make in
            make.left.equalTo(contentForQRCode).inset(20)
            make.top.equalTo(textForQRCodePart1.snp.bottom).offset(5)
        }
        
        textForPHWritten.snp.makeConstraints { make in
            make.left.equalTo(placeholderForWrittenButton).inset(20)
            make.centerY.equalTo(placeholderForWrittenButton)
        }
        
        whatsAppButton.snp.makeConstraints { make in
            make.left.equalTo(telegramButton.snp.right).offset(10)
            make.size.equalTo(35)
            make.centerY.equalTo(placeholderForWrittenButton)
        }
        
        telegramButton.snp.makeConstraints { make in
            make.left.equalTo(instagramButton.snp.right).offset(10)
            make.size.equalTo(35)
            make.centerY.equalTo(placeholderForWrittenButton)
        }
        
        instagramButton.snp.makeConstraints { make in
            make.left.equalTo(textForPHWritten.snp.right).offset(20)
            make.size.equalTo(35)
            make.centerY.equalTo(placeholderForWrittenButton)
        }
        
        placeholderForWrittenButton.snp.makeConstraints { make in
            make.centerX.equalTo(headerView)
            make.bottom.equalTo(headerView).inset(35)
            make.height.equalTo(70)
            make.width.equalTo(300)
        }
        
        placeholderForBonuses.snp.makeConstraints { make in
            make.centerX.equalTo(headerView)
            make.bottom.equalTo(placeholderForWrittenButton.snp.top)
            make.height.width.equalTo(placeholderForWrittenButton)
        }
        
        bonusPoint.snp.makeConstraints { make in
            make.center.equalTo(placeholderForBonuses)
        }
        
        headerView.snp.makeConstraints { make in
            make.left.right.equalTo(mainContentView)
            make.top.equalTo(mainContentView)
        }
        
        mainContentView.snp.makeConstraints { make in
            make.left.right.width.equalTo(mainScrollView)
            make.top.equalTo(mainScrollView)
            make.bottom.equalTo(mainScrollView).inset(40)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func setupSideMenu() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let funcButton = createCustomButton(imageName: "line.3.horizontal", selector: #selector(sideMenuBtn))
        
        if uid == "" {
            
        } else {
            navigationItem.leftBarButtonItem = funcButton
        }
        
        menu = SideMenuNavigationController(rootViewController: SideMenuNC())
        menu?.leftSide = true
        menu?.presentationStyle = .viewSlideOutMenuIn
        menu?.menuWidth = 300
        menu?.presentationStyle.onTopShadowOpacity = 1
    }
    
    private func lottie() {
        var lottie = LottieAnimationView()
        lottie = .init(name: "GoldenLottie2")
        placeholderForBonuses.addSubview(lottie)
        lottie.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(headerView)
        }
        lottie.contentMode = .scaleAspectFit
        lottie.loopMode = .playOnce
        lottie.animationSpeed = 3.0
        lottie.play()
    }
    
    private func getRealTimeBonus2() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("usersBonus").document(uid).addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else { return }
                
                guard let data = document.data()?["Bonus"] else { return }
                self.points = data as! Int
                self.bonusPoint.text = "\(self.points) баллов"
                let scene = SheetBonus()
                scene.modalPresentationStyle = .fullScreen
                self.present(scene, animated: true)
        }
    }
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = max(1, scrollView.contentOffset.y)
    }
}

extension MainViewController {

    @objc private func tapPHBonus1(_ gesture: UITapGestureRecognizer) {
        let scene = SalesViewController1()
        if let sheet = scene.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.preferredCornerRadius = 28
            sheet.prefersGrabberVisible = true
        }
        present(scene, animated: true)
    }
    
    @objc private func tapPHBonus2(_ gesture: UITapGestureRecognizer) {
        let scene = SalesViewController2()
        if let sheet = scene.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 28
            sheet.prefersGrabberVisible = true
        }
        present(scene, animated: true)
    }
    
    @objc private func tapPHBonus3(_ gesture: UITapGestureRecognizer) {
        let url = "https://wa.me/+79180235043"
        openUrl(urlString: url)
    }
    
    @objc private func refresh() {
        Service.getBonusPoint { bonusPoint in
            self.bonusPoint.text = "\(bonusPoint ?? 0) баллов"
        }
        animateView(placeholderForBonuses)
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
    
    @objc private func tapPOF(_ gesture: UITapGestureRecognizer) {
        let scene = ProcedureOfMoneyViewController()
        scene.modalPresentationStyle = .fullScreen
        present(scene, animated: true)
    }
    
    @objc private func tapPHForText1(_ gesture: UITapGestureRecognizer) {
        let scene = BonusViewController1()
        scene.modalPresentationStyle = .fullScreen
        present(scene, animated: true)
    }
    
    @objc private func tapPHForText2(_ gesture: UITapGestureRecognizer) {
        let scene = BonusViewController2()
        scene.modalPresentationStyle = .fullScreen
        present(scene, animated: true)
    }
    
    @objc private func tapPHForText3(_ gesture: UITapGestureRecognizer) {
        let scene = BonusViewController3()
        scene.modalPresentationStyle = .fullScreen
        present(scene, animated: true)
    }
    
    @objc private func tapPHForText4(_ gesture: UITapGestureRecognizer) {
        let scene = BonusViewController4()
        scene.modalPresentationStyle = .popover
        present(scene, animated: true)
    }
    
    @objc private func callTapped(_ gesture: UITapGestureRecognizer) {
        callPhone(string: "tel://+79180235043")
    }
    
    @objc private func callPhone(string: String) {
        UIApplication.shared.open(NSURL(string: string)! as URL)
    }
    
    @objc private func InstaTapped(_ gesture: UITapGestureRecognizer) {
        openUrl(urlString: "https://instagram.com/juliana.berezhnaya_?igshid=MDM4ZDc5MmU=")
    }
    
    @objc private func LocationTapped(_ gesture: UITapGestureRecognizer) {
        let scene = LocationViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapTelegram() {
        openUrl(urlString: "https://t.me/juliana_cosm")
    }
    
    @objc private func tapWA() {
        openUrl(urlString: "https://wa.me/+79180235043")
    }
    
    @objc private func tapInsta() {
        openUrl(urlString: "https://instagram.com/juliana.berezhnaya_?igshid=MDM4ZDc5MmU=")
    }
    
    @objc private func tapQR(_ gesture: UITapGestureRecognizer) {
        let scene = QRCodeViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func tapBoxNew1(_ gesture: UITapGestureRecognizer) {
        let scene = PriceViewController()
        scene.modalPresentationStyle = .popover
        present(scene, animated: true)
    }
    
    @objc private func tapBoxNew2(_ gesture: UITapGestureRecognizer) {
        let scene = ConditionsViewController()
        scene.modalPresentationStyle = .popover
        present(scene, animated: true)
    }
    
    @objc private func tapBoxNew3(_ gesture: UITapGestureRecognizer) {
        let scene = FeedBackViewController()
        scene.modalPresentationStyle = .popover
        present(scene, animated: true)
    }
    
    @objc private func tapBoxNew4(_ gesture: UITapGestureRecognizer) {
        let urlWhats = "https://wa.me/+79180235043"
        openUrl(urlString: urlWhats)
    }
    
    @objc private func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    //MARK: - Func for button's
    
    @objc private func shopBtn() {
        let scene = ShopCartViewController()
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @objc private func sideMenuBtn() {
        present(menu!, animated: true)
    }
    
    func passString(sumString: String) {
        print(sumString)
    }
    
}

extension CAShapeLayer {
    func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}

private var handle: UInt8 = 0;

extension UIBarButtonItem {
    
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as? AnyObject {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(_ number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        badgeLayer?.removeFromSuperlayer()
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(7)
        let location = CGPoint(x: view.frame.width - (radius + offset.x), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = CATextLayerAlignmentMode.center
        label.fontSize = 11
        label.frame = CGRect(origin: CGPoint(x: location.x - 4, y: offset.y), size: CGSize(width: 8, height: 16))
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func updateBadge(_ number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}

