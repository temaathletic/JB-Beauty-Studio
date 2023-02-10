//
//  BonusViewController1.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 07.01.2023.
//

import UIKit
import SnapKit
import BottomPopup

class UserModel1 {
    var labelLbl: String?
    var priceLbl: String?
    
    init(label: String, price: String) {
        self.labelLbl = label
        self.priceLbl = price
    }
}

class BonusViewController1: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var UserArr = [UserModel1]()
    let cellSpacingHeight: CGFloat = 15
    
    private var swipeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let background: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bgForPriceVC")
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let bonusLabel: UILabel = {
        let text = UILabel()
        text.text = "БАЛЛЫ"
        text.textColor = .black
        text.textAlignment = .right
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 23)
        return text
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.bouncesZoom = false
        tableView.register(CustomTableViewCellForGiftOfPoint.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .none
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        
        background.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        background.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        background.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        background.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        
        tableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        tableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        tableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        tableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        
        
        view.addSubview(background)
        background.addSubview(swipeView)
        swipeView.addSubview(bonusLabel)
        swipeView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        UserArr.append(UserModel1(label: ResourceText.contourPlastic1, price: ResourceInt.contourPlastic1))
        UserArr.append(UserModel1(label: ResourceText.contourPlastic2, price: ResourceInt.contourPlastic2))
        UserArr.append(UserModel1(label: ResourceText.contourPlastic3, price: ResourceInt.contourPlastic3))
        UserArr.append(UserModel1(label: ResourceText.contourPlastic4, price: ResourceInt.contourPlastic4))
        UserArr.append(UserModel1(label: ResourceText.contourPlastic5, price: ResourceInt.contourPlastic5))
        UserArr.append(UserModel1(label: ResourceText.contourPlastic6, price: ResourceInt.contourPlastic6))
        UserArr.append(UserModel1(label: ResourceText.contourPlastic7, price: ResourceInt.contourPlastic7))
        UserArr.append(UserModel1(label: ResourceText.contourPlastic8, price: ResourceInt.contourPlastic8))
        
        background.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        swipeView.snp.makeConstraints { make in
            make.centerX.equalTo(background)
            make.left.right.equalTo(background).inset(15)
            make.bottom.equalTo(background)
            make.top.equalTo(background).inset(60)
        }
        
        bonusLabel.snp.makeConstraints { make in
            make.left.right.equalTo(swipeView).inset(30)
            make.top.equalTo(swipeView).inset(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(bonusLabel.snp.bottom)
            make.left.right.equalTo(swipeView)
            make.bottom.equalTo(swipeView).inset(100)
        }
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
     func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        // Initialize Swipe Gesture Recognizer
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))

        // Configure Swipe Gesture Recognizer
        swipeGestureRecognizer.direction = direction

        return swipeGestureRecognizer
    }
    
    // MARK: - Table View delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return UserArr.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCellForGiftOfPoint
        
        cell!.label.text = UserArr[indexPath.section].labelLbl
        cell!.price.text = UserArr[indexPath.section].priceLbl
        cell!.selectionStyle = .none
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let popUp = PopUpViewController1()
            present(popUp, animated: true)
        } else if indexPath.section == 1 {
            let popUp = PopUpViewController2()
            present(popUp, animated: true)
        } else if indexPath.section == 2 {
            let popUp = PopUpViewController3()
            present(popUp, animated: true)
        } else if indexPath.section == 3 {
            let popUp = PopUpViewController4()
            present(popUp, animated: true)
        }  else if indexPath.section == 4 {
            let popUp = PopUpViewController5()
            present(popUp, animated: true)
        } else if indexPath.section == 5 {
            let popUp = PopUpViewController6()
            present(popUp, animated: true)
        } else if indexPath.section == 6 {
            let popUp = PopUpViewController7()
            present(popUp, animated: true)
        }  else if indexPath.section == 7 {
            let popUp = PopUpViewController8()
            present(popUp, animated: true)
        }
    }
}




