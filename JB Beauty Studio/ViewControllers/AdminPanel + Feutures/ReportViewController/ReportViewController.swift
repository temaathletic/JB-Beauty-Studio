//
//  ReportViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 18.02.2023.
//

import UIKit
import SnapKit

class ReportArray {
    var email = ""
    var message = ""
    
    convenience init(withDoc: DocumentSnapshot) {
        self.init()
        self.email = withDoc.get("Email") as? String ?? "Нет данных"
        self.message = withDoc.get("Problem") as? String ?? "Нет данных"
    }
}

class ReportViewController: UIViewController {
    
    var userFBData = [ReportArray]()
    var filterUserData = [ReportArray]()
    var filterUserBonus = [ReportArray]()
    var isSearching = false
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.bouncesZoom = false
        tableView.isUserInteractionEnabled = true
        tableView.register(CustomTableViewCellForReport.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        getConversations()
        getConversations2()
        Service.afterBlock(seconds: 1, queue: .main) {
        self.tableView.reloadData()
        }
        
        view.backgroundColor = Color.mainBackgroundColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

extension ReportViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filterUserData.removeAll()
        guard searchText != "" || searchText != " " else { return }
        
        for item in userFBData {
            let text = searchText.lowercased()
            let arrayContain = item.email.lowercased().range(of: text)
            
            
            if arrayContain != nil {
                filterUserData.append(item)
            }
            
            if searchBar.text == "" {
                isSearching = false
                tableView.reloadData()
            } else {
                isSearching = true
                filterUserData = userFBData.filter({$0.email.contains(searchBar.text ?? "")})
                tableView.reloadData()
            }
        }
    }
}

extension ReportViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ReportViewController: UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCellForReport
        
        if isSearching {
            let filterBonus = filterUserBonus[indexPath.row]
            cell!.emailLabel.text = "Почта: \(filterBonus.email)"
            cell!.messageLabel.text = "Проблема: \(filterBonus.message)"
        } else {
            let model = userFBData[indexPath.row]
            cell!.emailLabel.text = "Почта: \(model.email)"
            cell!.messageLabel.text = "Проблема: \(model.message)"
        }
        
        cell!.selectionStyle = .none
        
        return cell!
    }
}

import FirebaseAuth
import FirebaseFirestore

extension ReportViewController {
    
    func getConversations() {
        
        let db = Firestore.firestore()
        let collection = db.collection("usersProblem")
        collection.getDocuments(completion: { snapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = snapshot?.documents else { return }
            self.userFBData = [ReportArray]()
            
            for doc in docs {
                let array = ReportArray(withDoc: doc)
                self.userFBData.append(array)
            }
        })
    }
    
    func getConversations2() {
        
        let db = Firestore.firestore()
        let collection = db.collection("usersProblem")
        collection.getDocuments(completion: { snapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = snapshot?.documents else { return }
            self.filterUserBonus = [ReportArray]()
            
            for doc in docs {
                let bonus = ReportArray(withDoc: doc)
                self.filterUserBonus.append(bonus)
            }
        })
    }
}

