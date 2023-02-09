//
//  ShopCartViewCoontroller.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit

class ShopCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellSpacingHeight: CGFloat = 5
    
    private lazy var callButt: UIButton = {
        let button = UIButton()
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.08235294118, blue: 0, alpha: 1)
        button.addTarget(self, action: #selector(tapCall), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var qrCodeBut: UIButton = {
        let button = UIButton()
        button.setTitle("Показать QR Code", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.08235294118, blue: 0, alpha: 1)
        button.addTarget(self, action: #selector(tapWrite), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.bouncesZoom = false
        tableView.register(CustomTableViewCellForCart.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .none
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        title = "Корзина"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.addSubview(callButt)
        view.addSubview(qrCodeBut)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.bottom.equalTo(callButt.snp.top).inset(-20)
        }

        callButt.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.width.equalTo(view.frame.width / 2.3)
        }
        
        qrCodeBut.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.width.equalTo(view.frame.width / 2.3)
        }
    }
    
    // MARK: - Table View delegate methods
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            Base.shared.orders.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Base.shared.orders.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCellForCart
    
        cell!.label.text = Base.shared.orders[indexPath.section].labelLbl
        cell!.price.text = Base.shared.orders[indexPath.section].priceLbl
        cell!.selectionStyle = .none
        return cell!
    }
}

extension ShopCartViewController {
    
    @objc private func tapWrite() {
        openUrl(urlString: "https://wa.me/+79180142070")
    }
    
    @objc private func tapCall() {
        callPhone(string: "tel://89180142070")
    }
    
    @objc private func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc private func callPhone(string: String) {
            UIApplication.shared.open(NSURL(string: string)! as URL)
        }
}

#if DEBUG
import SwiftUI

@available(iOS 15, *)
struct InfoVCPreview: PreviewProvider {
    
    static var previews: some View {

        ShopCartViewController().toPreview()
    }
}
#endif
