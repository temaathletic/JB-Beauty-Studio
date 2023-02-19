//
//  ShopCartViewCoontroller.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit
import SwipeCellKit
import CoreData

class ShopCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate, DataDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    public var myOrder = [MyOrders]()
    
    let cellSpacingHeight: CGFloat = 5
    
    private lazy var callButt: UIButton = {
        let button = UIButton()
        button.setTitle("Консультация", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.addTarget(self, action: #selector(tapCall), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var sumCart: UILabel = {
        let sum = UILabel()
        sum.text = "Итого:"
        sum.textColor = .systemGray2
        sum.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        sum.textAlignment = .left
        return sum
    }()
    
    private lazy var sale: UILabel = {
        let sum = UILabel()
        sum.text = "Ваша скидка:"
        sum.textColor = .systemGray2
        sum.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        sum.textAlignment = .left
        return sum
    }()
    
    private lazy var sumCartWithSale: UILabel = {
        let sum = UILabel()
        sum.text = "Итого с учетом сикдки:"
        sum.textColor = Color.mainTextColor
        sum.font = UIFont(name: "GlacialIndifference-Bold", size: 20)
        sum.textAlignment = .left
        return sum
    }()
    
    lazy var totalWithSaleForFB: UILabel = {
        let sum = UILabel()
        Service.getSale(completion: { sale in
            sum.text = sale
            
            let saleForSum = self.myOrder.map({$0.price}).reduce(0, +)
            
            let sale3 = saleForSum - saleForSum / 100 * 3
            let sale5 = saleForSum - saleForSum / 100 * 5
            let sale7 = saleForSum - saleForSum / 100 * 7
            let sale10 = saleForSum - saleForSum / 100 * 10
            
            if sale == "3%" {
                sum.text = "\(sale3)"
            } else if sale == "5%" {
                sum.text = "\(sale5)"
            }  else if sale == "7%" {
                sum.text = "\(sale7)"
            }  else if sale == "10%" {
                sum.text = "\(sale10)"
            }
            
            self.getAllItem()
        })
        return sum
    }()
    
    private lazy var totalWithSale: UILabel = {
        let sum = UILabel()
        sum.textColor = Color.mainTextColor
        Service.getSale(completion: { sale in
            sum.text = sale
            
            let saleForSum = self.myOrder.map({$0.price}).reduce(0, +)
            
            let sale3 = saleForSum - saleForSum / 100 * 3
            let sale5 = saleForSum - saleForSum / 100 * 5
            let sale7 = saleForSum - saleForSum / 100 * 7
            let sale10 = saleForSum - saleForSum / 100 * 10
            
            if sale == "3%" {
                sum.text = "\(sale3) ₽"
            } else if sale == "5%" {
                sum.text = "\(sale5) ₽"
            }  else if sale == "7%" {
                sum.text = "\(sale7) ₽"
            }  else if sale == "10%" {
                sum.text = "\(sale10) ₽"
            }
            
            self.getAllItem()
        })
        sum.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        sum.textAlignment = .left
        return sum
    }()
    
    private lazy var total: UILabel = {
        let sum = UILabel()
        sum.textColor = .systemGray2
        sum.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        sum.textAlignment = .left
        return sum
    }()
    
    private lazy var personalSale: UILabel = {
        let sum = UILabel()
        Service.getSale(completion: { sale in
            sum.text = sale
            
            let saleForSum = self.myOrder.map({$0.price}).reduce(0, +)
            
            let sale3 = saleForSum / 100 * 3
            let sale5 = saleForSum / 100 * 5
            let sale7 = saleForSum / 100 * 7
            let sale10 = saleForSum / 100 * 10
            
            if sale == "3%" {
                sum.text = "\(sale3) ₽"
            } else if sale == "5%" {
                sum.text = "\(sale5) ₽"
            }  else if sale == "7%" {
                sum.text = "\(sale7) ₽"
            }  else if sale == "10%" {
                sum.text = "\(sale10) ₽"
            }
            
            self.getAllItem()
        })
        sum.textColor = .systemGray2
        sum.font = UIFont(name: "GlacialIndifference-Bold", size: 25)
        sum.textAlignment = .left
        return sum
    }()
    
    private lazy var qrCodeBut: UIButton = {
        let button = UIButton()
        button.setTitle("Показать QR Code", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.addTarget(self, action: #selector(showQR), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.bouncesZoom = false
        tableView.isUserInteractionEnabled = true
        tableView.register(CustomTableViewCellForCart.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .none
        return tableView
    }()
    
    private let line1: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray2
        return line
    }()
    
    private let line2: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray2
        return line
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllItem()
        totalCost()
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = Color.mainBackgroundColor
        
        title = "Корзина"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = Color.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Color.mainTextColor!]
        let backBut = createLeftButtonForCart(imageName: "chevron.backward", selector: #selector(backAlert))
        let resetBut = createRightButtonForCart(imageName: "trash", selector: #selector(deleteAll))
        navigationItem.leftBarButtonItem = backBut
        navigationItem.rightBarButtonItem = resetBut
        
        view.addSubview(callButt)
        view.addSubview(qrCodeBut)
        view.addSubview(tableView)
        view.addSubview(sumCart)
        view.addSubview(sale)
        view.addSubview(sumCartWithSale)
        view.addSubview(totalWithSaleForFB)
        view.addSubview(totalWithSale)
        view.addSubview(personalSale)
        view.addSubview(total)
        view.addSubview(line1)
        view.addSubview(line2)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.mainBackgroundColor
        tableView.separatorStyle = .none
        
        line1.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        line2.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalTo(total.snp.top).inset(-5)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(line1.snp.bottom)
            make.bottom.equalTo(line2.snp.top)
        }
        
        sumCart.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalTo(sale.snp.top).inset(-20)
        }
        
        sale.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalTo(sumCartWithSale.snp.top).inset(-10)
        }
        
        sumCartWithSale.snp.makeConstraints { make in
            make.bottom.equalTo(callButt.snp.top).inset(-15)
            make.height.equalTo(50)
            make.left.equalToSuperview().inset(20)
        }
        
        total.snp.makeConstraints { make in
            make.centerY.equalTo(sumCart)
            make.height.equalTo(50)
            make.right.equalToSuperview().inset(20)
        }
        
        personalSale.snp.makeConstraints { make in
            make.centerY.equalTo(sale)
            make.height.equalTo(50)
            make.right.equalToSuperview().inset(20)
        }
        
        totalWithSale.snp.makeConstraints { make in
            make.bottom.equalTo(callButt.snp.top).inset(-15)
            make.height.equalTo(50)
            make.right.equalToSuperview().inset(20)
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
    
    // MARK: - Table View Swipe delegate methods
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let item = myOrder[indexPath.row]
        let deleteAction = SwipeAction(style: .destructive, title: .none) { action, indexPath in
            self.deleteItem(item: item, with: .fade)
            self.totalCost()
            self.getAllItem()
        }
        
        // customize the action appearance
        deleteAction.backgroundColor = Color.mainBackgroundColor
        deleteAction.image = circularIcon(with: Color.mainRedColor!, size: CGSize(width: 50, height: 50), icon: UIImage(systemName: "trash.fill"))
        deleteAction.transitionDelegate = ScaleTransition.default
        deleteAction.style = .default
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .selection
        options.backgroundColor = Color.mainBackgroundColor
        options.transitionStyle = .reveal
        return options
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?, for orientation: SwipeCellKit.SwipeActionsOrientation) {
        
    }
    
    func visibleRect(for tableView: UITableView) -> CGRect? {
        return CGRect(x: view.frame.height / 2, y: view.frame.width / 2, width: 0, height: 0)
    }
    
    // MARK: - Table View delegate methods
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrder.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCellForCart
        
        cell?.delegate = self
        
        let model = myOrder[indexPath.row]
        cell!.label.text = model.name
        cell!.price.text = "\(model.price)"
        cell!.selectionStyle = .none
        
        return cell!
    }
}

// MARK: - Extension

extension ShopCartViewController {
    
    func circularIcon(with color: UIColor, size: CGSize, icon: UIImage? = nil) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        UIBezierPath(ovalIn: rect).addClip()
        
        color.setFill()
        UIRectFill(rect)
        
        if let icon = icon {
            let iconRect = CGRect(x: (rect.size.width - icon.size.width) / 2,
                                  y: (rect.size.height - icon.size.height) / 2,
                                  width: icon.size.width,
                                  height: icon.size.height)
            icon.draw(in: iconRect, blendMode: .destinationOut, alpha: 1)
        }
        
        defer { UIGraphicsEndImageContext() }
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    @objc func deleteAll() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MyOrders")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
            self.totalCost()
            self.getAllItem()
            self.navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    @objc func backAlert() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func showQR() {
        
        let total = totalWithSaleForFB.text
        Service.uploadCartSum(VariableSum: total ?? "0")
        getAllItem()
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss dd-MM-yyyy"
        let dateString = df.string(from: date)
        Service.uploadUserEntryInfo("\(dateString)", "\(myOrder.compactMap({$0.name}))")
        perform(#selector(passSumToVC), with: nil)
    }
    
    @objc func passSumToVC() {
        let vc = QRCodeFromTotalPriceViewController()
        vc.dataDelegate = self
        getAllItem()
        vc.totalSumDelegate = "\(totalCost2())"
        present(vc, animated: true)
    }
    
    
    @objc private func tapCall() {
        let scene = PopUpForCartViewController()
        scene.modalPresentationStyle = .fullScreen
        scene.modalTransitionStyle = .coverVertical
        present(scene, animated: true)
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

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}

//MARK: - Func for Local DataBase

extension ShopCartViewController {
    
    public func getAllItem() {
        
        do {
            myOrder = try context.fetch(MyOrders.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    public func createItem(name: String, price: Int64, quantity: Int64) {
        let newItem = MyOrders(context: context)
        newItem.name = name
        newItem.price = price
        newItem.quantity = quantity
        do {
            try context.save()
            getAllItem()
        }
        catch {
            
        }
    }
    
    public func deleteItem(item: MyOrders, with: UITableView.RowAnimation) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItem()
        }
        catch {
        }
    }
    
    public func totalCost() {
        let totalSum = "\(myOrder.map({$0.price}).reduce(0, +)) ₽"
        total.text = "\(totalSum)"
    }
    
    public func totalCost2() -> String {
        let totalSum = "\(myOrder.map({$0.price}).reduce(0, +))"
        getAllItem()
        return totalSum
    }
    
    public func intTotalSum() -> Int {
        let totalSum = (myOrder.map({$0.price}).reduce(0, +))
        getAllItem()
        return Int(totalSum)
    }
    
    func passString(sumString: String) {
        print(sumString)
    }
}

//MARK: - Life Preview

#if DEBUG
import SwiftUI

@available(iOS 15, *)
struct InfoVCPreview: PreviewProvider {
    
    static var previews: some View {
        
        ShopCartViewController().toPreview()
    }
}
#endif
