//
//  ScanSaleViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 13.02.2023.
//

import UIKit
import SnapKit

class ScanSaleViewController: UIViewController {
    
    public var uidFromScaner = ""
    
    public let allProcedure = ["Губы 1 мл", "Губы 0.5 мл","Исправление губ после другого мастера", "Коррекция носогубных складок", "Коррекция подбородка", "Коррекция формы носа", "Носослезка", "Щечки-яблочки", "Скулы","Лоб", "Межбровка", "Гусиные лапки" ,"Узкий нос", "Гипергидроз для девушек", "Гипергидроз для мужчин","Биоревитализация", "Коллагенотерапия", "Мезотерапия волос", "Мезотерапия", "Безоперационный плазмолифтинг", "Липолитики", "МОНОНИТИ", "1 Варивнт", "2 Варинат"]
    public let allProcedurePrice = [8000,5500,12000,8000,8000,7500,6000,8000,16000,3500,2500,2500,5000,8000,10000,2500,12000,2500,12500,3500,2500,2500, 30000, 42000]
    public var newCategory = [Int]()
    public var newCategoryName = [String]()
    var checkmark: Set<Int> = []
    
    var isHidden: Bool!
    var selectedIndexPaths : [String:Bool] = [:]
    
    //    private lazy var chooseButton: UIButton = {
    //        let button = UIButton()
    //        button.setTitle("Выбрать", for: .normal)
    //        button.setTitleColor(Color.mainTextColor, for: .normal)
    //        button.backgroundColor = Color.mainRedColor
    //        button.layer.cornerRadius = 15
    //        button.isUserInteractionEnabled = true
    //        button.addTarget(self, action: #selector(choose), for: .touchUpInside)
    //        return button
    //    }()
    
    private let procedureLabel: UILabel = {
        let text = UILabel()
        text.text = "Введите процедуру"
        text.textAlignment = .left
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let saleLabel: UILabel = {
        let text = UILabel()
        text.text = "Введите скидку"
        text.textAlignment = .left
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let saleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Color.mainBackgroundColorWithOppacity
        textField.textColor = Color.mainTextColor
        textField.layer.borderColor = Color.mainTextColor?.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let procentIcon: UILabel = {
        let icon = UILabel()
        icon.text = "%"
        icon.textColor = Color.mainTextColor
        icon.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return icon
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.bouncesZoom = false
        tableView.register(CustomTableViewCellForSale.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = Color.mainBackgroundColor
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.mainBackgroundColor
        
        isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = true
        tableView.isHidden = false
        
        view.addSubview(procedureLabel)
        view.addSubview(saleLabel)
        view.addSubview(procentIcon)
        view.addSubview(saleTextField)
        view.addSubview(tableView)
        //        view.addSubview(chooseButton)
        view.addSubview(saveButton)
        
        procedureLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().inset(15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(procedureLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
        
        saleLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).inset(-20)
            make.left.equalToSuperview().inset(15)
        }
        
        procentIcon.snp.makeConstraints { make in
            make.left.equalTo(saleTextField.snp.right).inset(-5)
            make.centerY.equalTo(saleTextField)
        }
        
        saleTextField.snp.makeConstraints { make in
            make.top.equalTo(saleLabel.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
            make.size.equalTo(50)
        }
        
        //        chooseButton.snp.makeConstraints { make in
        //            make.top.equalTo(saleTextField.snp.bottom).inset(-35)
        //            make.centerX.equalToSuperview()
        //            make.height.equalTo(60)
        //            make.width.equalTo(160)
        //        }
        
        saveButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ScanSaleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProcedure.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCellForSale
        let procedure = allProcedure[indexPath.row]
        cell.label.text = procedure.description
        cell.selectionStyle = .none
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    //    @objc func choose() {
    //        newCategory.removeAll()
    //        if let selectedRows = tableView.indexPathsForSelectedRows {
    //            for iPath in selectedRows {
    //                newCategory.append(allProcedurePrice[iPath.row])
    //            }
    //
    //        }
    //    }
    
    @objc private func saveButtonAction() {

        newCategory.removeAll()
        if let selectedRows = tableView.indexPathsForSelectedRows {
            for iPath in selectedRows {
                newCategory.append(allProcedurePrice[iPath.row])
            }
        }
            
            for item in newCategory {
                print(item)
                guard let intValue = Int(self.saleTextField.text!) else { return }
                print("Sum - > \((intTotalSum()) - intTotalSum() / 100 * intValue)")
            }
            
            guard let intValue = Int(self.saleTextField.text!) else { return }
            let newBonus = ((intTotalSum()) - intTotalSum() / 100 * intValue) / 100 * 1
            
            Service.getBonusPointForDecriment(self.uidFromScaner) { bonusPoint in
                let bonusPoint = bonusPoint ?? 0
                let newNewBonus = newBonus + bonusPoint
                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "HH:mm:ss dd-MM-yyyy"
                let dateString = df.string(from: date)
                Service.uploadBonusPoint(newBonus: newNewBonus, uid: self.uidFromScaner)
                self.newCategoryName.removeAll()
                if let selectedRows = self.tableView.indexPathsForSelectedRows {
                    for iPath in selectedRows {
                        self.newCategoryName.append(self.allProcedure[iPath.row])
                    }
                }
                
                Service.getUserFirstName(uid: self.uidFromScaner) { firstName in
                    Service.getUserSecondName(uid: self.uidFromScaner) { secondName in
                        let firstName = firstName ?? ""
                        let secondName = secondName ?? ""
                        Service.uploadINSessionLog(self.uidFromScaner, dateString, "\(self.newCategoryName)", firstName, secondName)
                    }
                }
            }
            dismiss(animated: true)
        }
        
        public func intTotalSum() -> Int {
            let totalSum = (newCategory.map({$0}).reduce(0, +))
            return totalSum
        }
    }
