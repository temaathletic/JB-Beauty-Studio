//
//  BonusViewController3.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 07.01.2023.
//

import UIKit
import SnapKit
import BottomPopup

class UserModel3 {
    var labelLbl: String?
    var priceLbl: String?
    
    init(label: String, price: String) {
        self.labelLbl = label
        self.priceLbl = price
    }
}

class BonusViewController3: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var UserArr = [UserModel3]()
    let cellSpacingHeight: CGFloat = 15
    
    private let bonusLabel: UILabel = {
        let text = UILabel()
        text.text = "БАЛЛЫ"
        text.textColor = .black
        text.textAlignment = .right
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 23)
        return text
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.isScrollEnabled = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bonusLabel)
        view.addSubview(tableView)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "LaunchBG")!)
        tableView.delegate = self
        tableView.dataSource = self
        
        UserArr.append(UserModel3(label: ResourceText.recoveryProcedures1, price: ResourceInt.recoveryProcedures1))
        UserArr.append(UserModel3(label: ResourceText.recoveryProcedures2, price: ResourceInt.recoveryProcedures2))
        UserArr.append(UserModel3(label: ResourceText.recoveryProcedures3, price: ResourceInt.recoveryProcedures3))
        UserArr.append(UserModel3(label: ResourceText.recoveryProcedures4, price: ResourceInt.recoveryProcedures4))
        UserArr.append(UserModel3(label: ResourceText.recoveryProcedures5, price: ResourceInt.recoveryProcedures5))
        UserArr.append(UserModel3(label: ResourceText.recoveryProcedures6, price: ResourceInt.recoveryProcedures6))
        
        bonusLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(bonusLabel.snp.bottom).offset(0)
            make.bottom.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(20)
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell
        
        cell!.label.text = UserArr[indexPath.section].labelLbl
        cell!.price.text = UserArr[indexPath.section].priceLbl
        cell!.selectionStyle = .none
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let popUp = PopUpViewController3_1()
            present(popUp, animated: true)
        } else if indexPath.section == 1 {
            let popUp = PopUpViewController3_2()
            present(popUp, animated: true)
        } else if indexPath.section == 2 {
            let popUp = PopUpViewController3_3()
            present(popUp, animated: true)
        } else if indexPath.section == 3 {
            let popUp = PopUpViewController3_4()
            present(popUp, animated: true)
        }  else if indexPath.section == 4 {
            let popUp = PopUpViewController3_5()
            present(popUp, animated: true)
        } else if indexPath.section == 5 {
            let popUp = PopUpViewController3_6()
            present(popUp, animated: true)
        }
    }
}
