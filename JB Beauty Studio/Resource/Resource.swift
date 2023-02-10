//
//  Resource.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 07.01.2023.
//

import Foundation
import UIKit

struct ProcedureList {
    let name: String
    let Price: Int
}

enum Color {
    static let mainRedColor = UIColor(named: "MainRed")
    static let mainBackgroundColor = UIColor(named: "Background")
    static let mainBackgroundColorWithOppacity  = UIColor(named: "BackgroundWithOppacity")
    static let mainTextColor = UIColor(named: "Text")
    static let mainTextColorWithOppacity = UIColor(named: "TextWithOppaciy")
    static let mainRedWithOppacity  = UIColor(named: "MainRedWithOppacity")
}

enum ProcedureName {
    static let procedureName1 = "БИОРЕВИТАЛИЗАЦИЯ"
    static let procedureName2 = "КОЛЛАГЕНОТЕРАПИЯ"
    static let procedureName3 = "МЕЗОТЕРАПИЯ ВОЛОС"
    static let procedureName4 = "МЕЗОТЕРАПИЯ"
    static let procedureName5 = "ПЛАЗМОЛИФТИНГ"
    static let procedureName6 = "МОНОНИТИ"
    static let procedureName7 = "ЛИПОЛИТИКИ"
    static let procedureName8 = "1 ВАРИАНТ"
    static let procedureName9 = "2 ВАРИАНТ"
    static let procedureName10 = "ИСПРАВЛЕНИЕ ГУБ"
    static let procedureName11 = "КОРРЕКЦИЯ НОСОГУБНЫХ СКЛАДОК"
    static let procedureName12 = "КОРРЕКЦИЯ ПОДБОРОДКА"
    static let procedureName13 = "КОРРЕКЦИЯ ФОРМЫ НОСА"
    static let procedureName14 = "НОСОСЛЕЗКА"
    static let procedureName15 = "ЩЕЧКИ-ЯБЛОЧКИ"
    static let procedureName16 = "СКУЛЫ"
    static let procedureName17 = "БОТУЛИНОТЕРАПИЯ"
    static let procedureName18 = "ЛОБ"
    static let procedureName19 = "МЕЖБРОВКА"
    static let procedureName20 = "ГУСИНЫЕ ЛАПКИ"
    static let procedureName21 = "УЗКИЙ НОС"
    static let procedureName22 = "ГИПЕРГИДРОЗ"
    static let procedureName23 = "ГИПЕРГИДРОЗ"
}

enum ProcedurePrice {
    static let procedurePrice1: Int64 = 2500
    static let procedurePrice2: Int = 12000
    static let procedurePrice3: Int = 2500
    static let procedurePrice4: Int = 12500
    static let procedurePrice5: Int = 3500
    static let procedurePrice6: Int = 12000
    static let procedurePrice7: Int = 2500
    static let procedurePrice8: Int = 30000
    static let procedurePrice9: Int = 42000
    static let procedurePrice10: Int = 12000
    static let procedurePrice11: Int = 8000
    static let procedurePrice12: Int = 8000
    static let procedurePrice13: Int = 7500
    static let procedurePrice14: Int = 6000
    static let procedurePrice15: Int = 8000
    static let procedurePrice16: Int = 16000
    static let procedurePrice17: Int = 250
    static let procedurePrice18: Int = 3500
    static let procedurePrice19: Int = 2500
    static let procedurePrice20: Int = 2500
    static let procedurePrice21: Int = 5000
    static let procedurePrice22: Int = 8000
    static let procedurePrice23: Int = 10000
}

enum ResourceText {
    
    static let contourPlastic1 = "УВЕЛЕЧЕНИЕ ГУБ \t0,5 мл"
    static let contourPlastic2 = "УВЕЛЕЧЕНИЕ ГУБ \t1 мл"
    static let contourPlastic3 = "НОСОГУБКИ"
    static let contourPlastic4 = "ПОДБОРОДОК"
    static let contourPlastic5 = "РИНОПЛАСТИКА"
    static let contourPlastic6 = "ЩЕЧКИ-ЯБЛОЧКИ"
    static let contourPlastic7 = "НОСОСЛЕЗКИ"
    static let contourPlastic8 = "СКУЛЫ"
    
    static let recoveryProcedures1 = "БИОРЕВИТАЛИЗАЦИЯ"
    static let recoveryProcedures2 = "КОЛЛАГЕНОТЕРАПИЯ"
    static let recoveryProcedures3 = "МЕЗОТЕРАПИЯ ВОЛОС"
    static let recoveryProcedures4 = "МЕЗОТЕРАПИЯ"
    static let recoveryProcedures5 = "ПЛАЗМОЛИФТИНГ"
    static let recoveryProcedures6 = "ЛИПОЛИТИКИ"
    
    static let botulinumTherapy1 = "ЛОБ"
    static let botulinumTherapy2 = "МЕЖБРОВКА"
    static let botulinumTherapy3 = "ГУСИНЫЕ ЛАПКИ"
    static let botulinumTherapy4 = "УЗКИЙ НОС"
    static let botulinumTherapy5 = "ГИПЕРГИДРОЗ \tженский"
    static let botulinumTherapy6 = "ГИПЕРГИДРОЗ \tмужской"
}

enum ResourceInt {
    
    static let contourPlastic1 = "1800"
    static let contourPlastic2 = "2600"
    static let contourPlastic3 = "2600"
    static let contourPlastic4 = "2600"
    static let contourPlastic5 = "2600"
    static let contourPlastic6 = "2600"
    static let contourPlastic7 = "1900"
    static let contourPlastic8 = "5300"
    
    static let recoveryProcedures1 = "800"
    static let recoveryProcedures2 = "4100"
    static let recoveryProcedures3 = "800"
    static let recoveryProcedures4 = "4200"
    static let recoveryProcedures5 = "1100"
    static let recoveryProcedures6 = "800"
    
    static let botulinumTherapy1 = "1100"
    static let botulinumTherapy2 = "800"
    static let botulinumTherapy3 = "800"
    static let botulinumTherapy4 = "1700"
    static let botulinumTherapy5 = "800"
    static let botulinumTherapy6 = "1000"
}


struct Category {
    var name: String
    var id: Int
}

struct Procedure {
    var name: String
    var id: Int
    var categoryID: Int
}

class ProcedureData {
    
    var category = [Category]()
    var procedure = [Procedure]()
    var procedureByCategory = [Procedure]()
    
    init() {
        setup()
    }
    
    func setup() {
        let category1 = Category(name: "Price List", id: 1)
        let category2 = Category(name: "Лицо под ключ", id: 2)
        let category3 = Category(name: "Контурная пластика", id: 3)
        let category4 = Category(name: "Ботулинотерапия", id: 4)
        
        category.append(category1)
        category.append(category2)
        category.append(category3)
        category.append(category4)
        
        let procedure1 = Procedure(name: "Биоревитализация", id: 1, categoryID: 1)
        let procedure2 = Procedure(name: "Коллагенотерапия", id: 2, categoryID: 1)
        let procedure3 = Procedure(name: "Мезотерапия волос", id: 3, categoryID: 1)
        let procedure4 = Procedure(name: "Мезотерапия", id: 4, categoryID: 1)
        let procedure5 = Procedure(name: "Плазмалифтинг", id: 5, categoryID: 1)
        let procedure6 = Procedure(name: "Мононити", id: 6, categoryID: 1)
        let procedure7 = Procedure(name: "Липолитики", id: 7, categoryID: 1)
        
        let procedure1_2 = Procedure(name: "1 Вариант", id: 1, categoryID: 2)
        let procedure2_2 = Procedure(name: "2 Вариант", id: 2, categoryID: 2)
        
        procedure.append(procedure1)
        procedure.append(procedure2)
        procedure.append(procedure3)
        procedure.append(procedure4)
        procedure.append(procedure5)
        procedure.append(procedure6)
        procedure.append(procedure7)
        
        procedure.append(procedure1_2)
        procedure.append(procedure2_2)
        
        self.procedureByCategory = getProcedure(categoryID: category.first!.id)
    }
    
    func getProcedure(categoryID: Int) -> [Procedure] {
        let procedure = self.procedure.filter { procedure in
            procedure.categoryID == categoryID
        }
        return procedure
    }
}
