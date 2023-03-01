//
//  ProcedureOfMoneyViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 28.01.2023.
//

import UIKit
import SnapKit

class ProcedureArray {
    
    struct procedureModel: Codable {
        
        var name: String
        var price: Int
        var description: String {
            return "\(name), \(price)"
        }
    }
}

class ProcedureOfMoneyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var procedureArray = [ProcedureArray.procedureModel]()
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
        text.text = "ЦЕНА ₽"
        text.textColor = .black
        text.textAlignment = .right
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        return text
    }()
    
    private let nameLabel: UILabel = {
        let text = UILabel()
        text.text = "ВЫБЕИТЕ ПРОЦЕДУРУ"
        text.textColor = .black
        text.textAlignment = .left
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        return text
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.bouncesZoom = false
        tableView.register(CustomTableViewCellForProcedureOfMoney.self, forCellReuseIdentifier: "Cell")
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
        
        let p1 = ProcedureArray.procedureModel(name: "БИОРЕВИТАЛИЗАЦИЯ", price: 2500)
        let p2 = ProcedureArray.procedureModel(name: "КОЛЛАГЕНОТЕРАПИЯ", price: 12000)
        let p3 = ProcedureArray.procedureModel(name: "МЕЗОТЕРАПИЯ ВОЛОС", price: 2500)
        let p4 = ProcedureArray.procedureModel(name: "МЕЗОТЕРАПИЯ", price: 12500)
        let p5 = ProcedureArray.procedureModel(name: "ПЛАЗМОЛИФТИНГ", price: 3500)
        let p6 = ProcedureArray.procedureModel(name: "МОНОНИТИ", price: 12000)
        let p7 = ProcedureArray.procedureModel(name: "ЛИПОЛИТИКИ", price: 2500)
        let p8 = ProcedureArray.procedureModel(name: "ЛИЦО ПОД КЛЮЧ 1", price: 30000)
        let p9 = ProcedureArray.procedureModel(name: "ЛИЦО ПОД КЛЮЧ 2", price: 42000)
        let p10 = ProcedureArray.procedureModel(name: "ИСПРАВЛЕНИЕ ГУБ", price: 12000)
        let p11 = ProcedureArray.procedureModel(name: "КОРРЕКЦИЯ НОСОГУБНЫХ СКЛАДОК", price: 8000)
        let p12 = ProcedureArray.procedureModel(name: "КОРРЕКЦИЯ ПОДБОРОДКА", price: 8000)
        let p13 = ProcedureArray.procedureModel(name: "КОРРЕКЦИЯ ФОРМЫ НОСА", price: 7500)
        let p14 = ProcedureArray.procedureModel(name: "НОСОСЛЕЗКА", price: 6000)
        let p15 = ProcedureArray.procedureModel(name: "ЩЕЧКИ-ЯБЛОЧКИ", price: 8000)
        let p16 = ProcedureArray.procedureModel(name: "СКУЛЫ", price: 16000)
//        let p17 = ProcedureArray.procedureModel(name: "БОТУЛИНОТЕРАПИЯ", price: 250)
        let p18 = ProcedureArray.procedureModel(name: "ЛОБ", price: 3500)
        let p19 = ProcedureArray.procedureModel(name: "МЕЖБРОВКА", price: 2500)
        let p20 = ProcedureArray.procedureModel(name: "ГУСИНЫЕ ЛАПКИ", price: 2500)
        let p21 = ProcedureArray.procedureModel(name: "УЗКИЙ НОС", price: 5000)
        let p22 = ProcedureArray.procedureModel(name: "ГИПЕРГИДРОЗ", price: 8000)
        let p23 = ProcedureArray.procedureModel(name: "ГИПЕРГИДРОЗ", price: 10000)

        procedureArray.append(p1)
        procedureArray.append(p2)
        procedureArray.append(p3)
        procedureArray.append(p4)
        procedureArray.append(p5)
        procedureArray.append(p6)
        procedureArray.append(p7)
        procedureArray.append(p8)
        procedureArray.append(p9)
        procedureArray.append(p10)
        procedureArray.append(p11)
        procedureArray.append(p12)
        procedureArray.append(p13)
        procedureArray.append(p14)
        procedureArray.append(p15)
        procedureArray.append(p16)
//        procedureArray.append(p17)
        procedureArray.append(p18)
        procedureArray.append(p19)
        procedureArray.append(p20)
        procedureArray.append(p21)
        procedureArray.append(p22)
        procedureArray.append(p23)
        
        
        view.addSubview(background)
        background.addSubview(swipeView)
        swipeView.addSubview(bonusLabel)
        swipeView.addSubview(nameLabel)
        swipeView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
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
            make.right.equalTo(swipeView).inset(30)
            make.top.equalTo(swipeView).inset(45)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(swipeView).inset(30)
            make.top.equalTo(swipeView).inset(45)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(bonusLabel.snp.bottom).inset(-15)
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
        return 1
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return procedureArray.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCellForProcedureOfMoney
        
        let procedure = procedureArray[indexPath.row]
        cell!.label.text = procedure.name
        cell!.price.text = String(procedure.price)
        cell!.selectionStyle = .none
        
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let scene = PopUpPriceViewController1()
            if let sheet = scene.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 28
                sheet.prefersGrabberVisible = true
            }
            present(scene, animated: true)
        } else if indexPath.row == 1 {
            let popUp = PopUpPriceViewController2()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 2 {
            let popUp = PopUpPriceViewController3()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 3 {
            let popUp = PopUpPriceViewController4()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        }  else if indexPath.row == 4 {
            let popUp = PopUpPriceViewController5()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 5 {
            let popUp = PopUpPriceViewController6()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 6 {
            let popUp = PopUpPriceViewController7()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        }  else if indexPath.row == 7 {
            let popUp = PopUpPriceViewController8()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 8 {
            let popUp = PopUpPriceViewController9()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 9 {
            let popUp = PopUpPriceViewController10()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        }  else if indexPath.row == 10 {
            let popUp = PopUpPriceViewController11()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 11 {
            let popUp = PopUpPriceViewController12()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 12 {
            let popUp = PopUpPriceViewController13()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        }  else if indexPath.row == 13 {
            let popUp = PopUpPriceViewController14()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 14 {
            let popUp = PopUpPriceViewController15()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 15 {
            let popUp = PopUpPriceViewController16()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
//        } else if indexPath.row == 16 {
//            let popUp = PopUpPriceViewController17()
//            present(popUp, animated: true)
        }  else if indexPath.row == 16 {
            let popUp = PopUpPriceViewController18()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 17 {
            let popUp = PopUpPriceViewController19()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 18 {
            let popUp = PopUpPriceViewController20()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        }  else if indexPath.row == 19 {
            let popUp = PopUpPriceViewController21()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 20 {
            let popUp = PopUpPriceViewController22()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        } else if indexPath.row == 21 {
            let popUp = PopUpPriceViewController23()
            if let popUp = popUp.sheetPresentationController {
                popUp.detents = [.medium()]
                popUp.preferredCornerRadius = 28
                popUp.prefersGrabberVisible = true
            }
            present(popUp, animated: true)
        }
    }
}





