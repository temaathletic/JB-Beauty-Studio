//
//  SearchPeopleViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 08.02.2023.
//

import UIKit
import SnapKit

class UserArray {
    var name = ""
    var login = ""
    var number = ""
    var location = ""
    var uid = ""
    var bonus = 0
    
    convenience init(withDoc: DocumentSnapshot) {
        self.init()
        self.name = withDoc.get("Name") as? String ?? "Нет данных"
        self.login = withDoc.get("Login") as? String ?? "Нет данных"
        self.number = withDoc.get("Phone") as? String ?? "Нет данных"
        self.location = withDoc.get("Location") as? String ?? "Нет данных"
        self.uid = withDoc.get("UID") as? String ?? "No UID"
        self.bonus = withDoc.get("Bonus") as? Int ?? 0
    }
}

class SearchPeopleViewController: UIViewController {
    
    var userFBData = [UserArray]()
    var filterUserData = [UserArray]()
    var filterUserBonus = [UserArray]()
    var isSearching = false
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.bouncesZoom = false
        tableView.isUserInteractionEnabled = true
        tableView.register(CustomTableViewCellForSearchPeople.self, forCellReuseIdentifier: "Cell")
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
    
    private let nameLabel: UILabel = {
        let text = UILabel()
        text.text = "Имя:"
        text.textAlignment = .left
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let numberLabel: UILabel = {
        let text = UILabel()
        text.text = "Номер:"
        text.textAlignment = .left
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let cityLabel: UILabel = {
        let text = UILabel()
        text.text = "Город:"
        text.textAlignment = .left
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let emaillabel: UILabel = {
        let text = UILabel()
        text.text = "Почта:"
        text.textAlignment = .left
        text.textColor = Color.mainTextColor
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        return text
    }()
    
    private let nameLabelFB: UILabel = {
        let text = UILabel()
        text.textAlignment = .left
        text.textColor = Color.mainTextColorWithOppacity
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 25)
        return text
    }()
    
    private let numberLabelFB: UILabel = {
        let text = UILabel()
        text.textAlignment = .left
        text.textColor = Color.mainTextColorWithOppacity
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 25)
        return text
    }()
    
    private let cityLabelFB: UILabel = {
        let text = UILabel()
        text.textAlignment = .left
        text.textColor = Color.mainTextColorWithOppacity
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 25)
        return text
    }()
    
    private let emaillabelFB: UILabel = {
        let text = UILabel()
        text.textAlignment = .left
        text.textColor = Color.mainTextColorWithOppacity
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 25)
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

extension SearchPeopleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filterUserData.removeAll()
        guard searchText != "" || searchText != " " else {
            return
        }
        
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

extension SearchPeopleViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SearchPeopleViewController: UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCellForSearchPeople
        
        if isSearching {
            let filter = filterUserData[indexPath.row]
            let filterBonus = filterUserBonus[indexPath.row]
            cell!.nameLabel.text = "Имя: \(filter.name)"
            cell!.loginLabel.text = "Почта: \(filter.login)"
            cell!.numberLabel.text = "Номер: \(filter.number)"
            cell!.locationLabel.text = "Баллы: \(filterBonus.bonus)"
        } else {
            let model = userFBData[indexPath.row]
            cell!.nameLabel.text = "Имя: \(model.name)"
            cell!.loginLabel.text = "Почта: \(model.login)"
            cell!.numberLabel.text = "Номер: \(model.number)"
            cell!.locationLabel.text = "Местоположение: \(model.location)"
        }
        
        cell!.selectionStyle = .none
        
        return cell!
    }
}

import FirebaseAuth
import FirebaseFirestore

extension SearchPeopleViewController {
    
    func getConversations() {
        
        let db = Firestore.firestore()
        let collection = db.collection("users")
        collection.getDocuments(completion: { snapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = snapshot?.documents else { return }
            self.userFBData = [UserArray]()
            
            for doc in docs {
                let array = UserArray(withDoc: doc)
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
            self.filterUserBonus = [UserArray]()
            
            for doc in docs {
                let bonus = UserArray(withDoc: doc)
                self.filterUserBonus.append(bonus)
            }
        })
    }
}
