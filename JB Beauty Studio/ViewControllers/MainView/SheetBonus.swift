//
//  SheetBonus.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 19.01.2023.
//

import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseAuth
import Lottie
import ViewAnimator

class SheetBonus: UIViewController {
    
    public var points = 0
    
    private let backgroound: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgoundBonus")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var placeholderForBonuses: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        return view
    }()
    
    private lazy var bonusPoint: UILabel = {
        let point = UILabel()
        Service.getBonusPoint { bonusPoint in
            point.text = "\(bonusPoint ?? 0) баллов"
        }
        point.numberOfLines = 0
        point.textAlignment = .center
        point.textColor = .white
        point.font = UIFont(name: "GlacialIndifference-Bold", size: 55)
        return point
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        getRealTimeBonus()
        
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        
        view.backgroundColor = .black
        
        view.addSubview(placeholderForBonuses)
        placeholderForBonuses.addSubview(bonusPoint)
        
        placeholderForBonuses.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        bonusPoint.snp.makeConstraints { make in
            make.center.equalTo(placeholderForBonuses)
            make.height.equalTo(150)
            make.width.equalTo(400)
        }
    }
}

extension SheetBonus {
    
    private func getRealTimeBonus() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("usersBonus").document(uid)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else { return }
                
                guard let data = document.data()!["Bonus"] else { return }
                self.points = data as! Int
                _ = AnimationType.from(direction: .bottom, offset: 25)
                UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseIn, animations:  {
                    self.placeholderForBonuses.transform = CGAffineTransform(scaleX: 30, y: 30)
                }) { (_) in
                    UIView.animate(withDuration: 0.2, delay: 0.2, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.4, options: .curveEaseIn) {
                        self.placeholderForBonuses.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }
                }
                self.bonusPoint.text = "\(data) баллов"
                self.lottie1()
                self.lottie2()
                self.lottie3()
            }
    }
    
    func lottie1() {
        var lottie = LottieAnimationView()
        lottie = .init(name: "GoldenLottie2")
        lottie.contentMode = .scaleAspectFill
        
        lottie.loopMode = .repeat(1)
        lottie.animationSpeed = 0.8
        view.addSubview(lottie)
        lottie.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        lottie.play()
    }
    
    func lottie2() {
        var lottie1 = LottieAnimationView()
        lottie1 = .init(name: "GoldenLottie2")
        lottie1.contentMode = .scaleAspectFill
        
        lottie1.loopMode = .repeat(1)
        lottie1.animationSpeed = 1.6
        view.addSubview(lottie1)
        lottie1.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        lottie1.play()
    }
    
    func lottie3() {
        var lottie = LottieAnimationView()
        lottie = .init(name: "GoldenLottie2")
        lottie.contentMode = .scaleAspectFill
        
        lottie.loopMode = .repeat(2)
        lottie.animationSpeed = 2.4
        view.addSubview(lottie)
        lottie.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        lottie.play()
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
     func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction

        return swipeGestureRecognizer
    }
    
    @objc private func refresh() {
        Service.getBonusPoint { bonusPoint in
            self.bonusPoint.text = "\(bonusPoint ?? 0) баллов"
        }
        lottie1()
    }
    
    @objc private func animateView(_ viewAnimate: UIView) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations:  {
            viewAnimate.transform = CGAffineTransform(scaleX: 3, y: 3)
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.4, options: .curveEaseIn) {
                viewAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
