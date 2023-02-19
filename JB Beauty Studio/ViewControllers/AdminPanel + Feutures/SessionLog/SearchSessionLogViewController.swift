//
//  SearchSessionLogViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 12.02.2023.
//

import UIKit
import SnapKit

class LogArray {
    var name = ""
    var secondName = ""
    var date = ""
    var procedureArray = ""
    
    convenience init(withDoc: DocumentSnapshot) {
        self.init()
        self.name = withDoc.get("Name") as? String ?? "Нет данных"
        self.secondName = withDoc.get("Secondname") as? String ?? "Нет данных"
        self.date = withDoc.get("EntryData") as? String ?? "Нет данных"
        self.procedureArray = withDoc.get("ShopList") as? String ?? "Нет данных"
    }
}

class SearchSessionLogViewController: UIViewController {
    
    var userFBData = [LogArray]()
    var filterUserData = [LogArray]()
    var filterUserBonus = [LogArray]()
    var isSearching = false
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.bouncesZoom = false
        tableView.isUserInteractionEnabled = true
        tableView.register(CustomTableViewCellForSessionLog.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .none
        return tableView
    }()
    
    private let labelMain: UILabel = {
        let text = UILabel()
        text.text = "Введите имя"
        text.textAlignment = .left
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let searchTextField: UISearchBar = {
        let field = UISearchBar()
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 1
        field.barTintColor = Color.mainBackgroundColor
        return field
    }()
    
    private lazy var searchButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Color.mainRedColor
        btn.setImage(UIImage(systemName: "person.fill"), for: .normal)
        btn.tintColor = Color.mainTextColor
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(search), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = Color.mainBackgroundColor
        
        print(userFBData)
        
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        view.addSubview(labelMain)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        
        
        labelMain.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(labelMain.snp.bottom).inset(-20)
            make.left.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField)
            make.left.equalTo(searchTextField.snp.right).inset(-10)
            make.right.equalToSuperview().inset(15)
            make.size.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).inset(-30)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    @objc private func search() {
        getConversations()
        getConversations2()
        Service.afterBlock(seconds: 1, queue: .main) {
            self.tableView.reloadData()
        }
    }
}

extension SearchSessionLogViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filterUserData.removeAll()
        guard searchText != "" || searchText != " " else { return }
        
        for item in userFBData {
            let text = searchText.lowercased()
            let arrayContain = item.name.lowercased().range(of: text)
            
            
            if arrayContain != nil {
                filterUserData.append(item)
            }
            
            if searchBar.text == "" {
                isSearching = false
                tableView.reloadData()
            } else {
                isSearching = true
                filterUserData = userFBData.filter({$0.name.contains(searchBar.text ?? "")})
                tableView.reloadData()
            }
        }
    }
}

extension SearchSessionLogViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SearchSessionLogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterUserData.count
        } else {
            return userFBData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCellForSessionLog
        
        if isSearching {
            let filter = filterUserData[indexPath.row]
            let filterBonus = filterUserBonus[indexPath.row]
            cell!.nameLabel.text = "Имя: \(filter.name) \(filter.secondName)"
            cell!.dateLabel.text = "Дата: \(filterBonus.procedureArray)"
            cell?.shopList.text = "Список: \(filterBonus.date)"
        } else {
            let model = userFBData[indexPath.row]
            cell!.nameLabel.text = "Имя: \(model.name) \(model.secondName)"
            cell?.dateLabel.text = "Дата: \(model.date)"
            cell!.shopList.text = "Список: \(model.procedureArray)"
        }
        
        cell!.selectionStyle = .none
        
        return cell!
    }
}

import FirebaseAuth
import FirebaseFirestore

extension SearchSessionLogViewController {
    
    func getConversations() {
        
        let db = Firestore.firestore()
        let collection = db.collection("SessionLog")
        collection.getDocuments(completion: { snapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = snapshot?.documents else { return }
            self.userFBData = [LogArray]()
            
            for doc in docs {
                let array = LogArray(withDoc: doc)
                self.userFBData.append(array)
            }
        })
    }
    
    func getConversations2() {
        
        let db = Firestore.firestore()
        let collection = db.collection("usersBonus")
        collection.getDocuments(completion: { snapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = snapshot?.documents else { return }
            self.filterUserBonus = [LogArray]()
            
            for doc in docs {
                let bonus = LogArray(withDoc: doc)
                self.filterUserBonus.append(bonus)
            }
        })
    }
}

