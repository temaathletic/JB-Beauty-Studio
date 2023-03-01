//
//  HidenCellsViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 28.02.2023.
//

import UIKit
import SnapKit

class HidenCellsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    //MARK: - Hiden First ScrollView
    
    private let text1: UILabel = {
        let text = UILabel()
        text.text = "Акции"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private let mainLabelBox1: UILabel = {
        let text = UILabel()
        text.text = "Скрыть все ячейкм"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var mainBox1: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switchMainSV1), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText1: UILabel = {
        let text = UILabel()
        text.text = "Скрыть акцию 1"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox1: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch1), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText2: UILabel = {
        let text = UILabel()
        text.text = "Скрыть акцию 2"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox2: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch2), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText3: UILabel = {
        let text = UILabel()
        text.text = "Скрыть акцию 3"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox3: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch3), for: .touchUpInside)
        return switcher
    }()
    
    //MARK: - Hiden Second ScrollView
    
    private let text2: UILabel = {
        let text = UILabel()
        text.text = "Кубики под акциями"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private let mainLabelBox2: UILabel = {
        let text = UILabel()
        text.text = "Скрыть все ячейкм"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var mainBox2: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switchMainSV2), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText4: UILabel = {
        let text = UILabel()
        text.text = "Скрыть прайс"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox4: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch4), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText5: UILabel = {
        let text = UILabel()
        text.text = "Скрыть условия"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox5: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch5), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText6: UILabel = {
        let text = UILabel()
        text.text = "Скрыть отзывы"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox6: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch6), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText7: UILabel = {
        let text = UILabel()
        text.text = "Скрыть обучение"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox7: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch7), for: .touchUpInside)
        return switcher
    }()
    
    //MARK: - Hiden Third ScrollView
    
    private let text3: UILabel = {
        let text = UILabel()
        text.text = "Подарки за баллы"
        text.font = UIFont(name: "GlacialIndifference-Bold", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private let mainLabelBox3: UILabel = {
        let text = UILabel()
        text.text = "Скрыть все ячейкм"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var mainBox3: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switchMainSV3), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText8: UILabel = {
        let text = UILabel()
        text.text = "Скрыть Контурную пластику"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox8: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch8), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText9: UILabel = {
        let text = UILabel()
        text.text = "Скрыть Ботулинотерапию"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox9: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch9), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText10: UILabel = {
        let text = UILabel()
        text.text = "Скрыть Процедуры восстановления"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox10: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch10), for: .touchUpInside)
        return switcher
    }()
    
    private let labelText11: UILabel = {
        let text = UILabel()
        text.text = "Скрыть Мерч"
        text.font = UIFont(name: "GlacialIndifference-Regular", size: 18)
        text.textColor = Color.mainTextColor
        text.textAlignment = .center
        return text
    }()
    
    private lazy var saleBox11: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(switch11), for: .touchUpInside)
        return switcher
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        mainBox1.isOn = UserDefaults.standard.bool(forKey: "mainBox1")
        saleBox1.isOn = UserDefaults.standard.bool(forKey: "saleBox1")
        saleBox2.isOn = UserDefaults.standard.bool(forKey: "saleBox2")
        saleBox3.isOn = UserDefaults.standard.bool(forKey: "saleBox3")
        mainBox2.isOn = UserDefaults.standard.bool(forKey: "mainBox2")
        saleBox4.isOn = UserDefaults.standard.bool(forKey: "saleBox4")
        saleBox5.isOn = UserDefaults.standard.bool(forKey: "saleBox5")
        saleBox6.isOn = UserDefaults.standard.bool(forKey: "saleBox6")
        saleBox7.isOn = UserDefaults.standard.bool(forKey: "saleBox7")
        mainBox3.isOn = UserDefaults.standard.bool(forKey: "mainBox3")
        saleBox8.isOn = UserDefaults.standard.bool(forKey: "saleBox8")
        saleBox9.isOn = UserDefaults.standard.bool(forKey: "saleBox9")
        saleBox10.isOn = UserDefaults.standard.bool(forKey: "saleBox10")
        saleBox11.isOn = UserDefaults.standard.bool(forKey: "saleBox11")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.mainBackgroundColor
        
        view.addSubview(text1)
        view.addSubview(mainLabelBox1)
        view.addSubview(mainBox1)
        view.addSubview(labelText1)
        view.addSubview(saleBox1)
        view.addSubview(labelText2)
        view.addSubview(saleBox2)
        view.addSubview(labelText3)
        view.addSubview(saleBox3)
        
        view.addSubview(text2)
        view.addSubview(mainLabelBox2)
        view.addSubview(mainBox2)
        view.addSubview(labelText4)
        view.addSubview(saleBox4)
        view.addSubview(labelText5)
        view.addSubview(saleBox5)
        view.addSubview(labelText6)
        view.addSubview(saleBox6)
        view.addSubview(labelText7)
        view.addSubview(saleBox7)
        
        view.addSubview(text3)
        view.addSubview(mainLabelBox3)
        view.addSubview(mainBox3)
        view.addSubview(labelText8)
        view.addSubview(saleBox8)
        view.addSubview(labelText9)
        view.addSubview(saleBox9)
        view.addSubview(labelText10)
        view.addSubview(saleBox10)
        view.addSubview(labelText11)
        view.addSubview(saleBox11)
        
        text1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.centerX.equalToSuperview()
        }
        
        mainLabelBox1.snp.makeConstraints { make in
            make.top.equalTo(text1.snp.bottom).inset(-20)
            make.left.equalToSuperview().inset(15)
        }
        
        mainBox1.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(mainLabelBox1)
        }
        
        labelText1.snp.makeConstraints { make in
            make.top.equalTo(mainLabelBox1.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox1.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText1)
        }
        
        labelText2.snp.makeConstraints { make in
            make.top.equalTo(labelText1.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox2.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText2)
        }
        
        labelText3.snp.makeConstraints { make in
            make.top.equalTo(labelText2.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox3.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText3)
        }
        
        text2.snp.makeConstraints { make in
            make.top.equalTo(labelText3.snp.bottom).inset(-30)
            make.centerX.equalToSuperview()
        }
        
        mainLabelBox2.snp.makeConstraints { make in
            make.top.equalTo(text2.snp.bottom).inset(-20)
            make.left.equalToSuperview().inset(15)
        }
        
        mainBox2.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(mainLabelBox2)
        }
        
        labelText4.snp.makeConstraints { make in
            make.top.equalTo(mainLabelBox2.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox4.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText4)
        }
        
        labelText5.snp.makeConstraints { make in
            make.top.equalTo(labelText4.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox5.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText5)
        }
        
        labelText6.snp.makeConstraints { make in
            make.top.equalTo(labelText5.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox6.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText6)
        }
        
        labelText7.snp.makeConstraints { make in
            make.top.equalTo(labelText6.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox7.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText7)
        }
        
        text3.snp.makeConstraints { make in
            make.top.equalTo(labelText7.snp.bottom).inset(-30)
            make.centerX.equalToSuperview()
        }
        
        mainLabelBox3.snp.makeConstraints { make in
            make.top.equalTo(text3.snp.bottom).inset(-20)
            make.left.equalToSuperview().inset(15)
        }
        
        mainBox3.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(mainLabelBox3)
        }
        
        labelText8.snp.makeConstraints { make in
            make.top.equalTo(mainLabelBox3.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox8.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText8)
        }
        
        labelText9.snp.makeConstraints { make in
            make.top.equalTo(labelText8.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox9.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText9)
        }
        
        labelText10.snp.makeConstraints { make in
            make.top.equalTo(labelText9.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox10.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText10)
        }
        
        labelText11.snp.makeConstraints { make in
            make.top.equalTo(saleBox10.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        saleBox11.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(labelText11)
        }
    }
    
    @objc private func switchMainSV1(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "ScrollView 2")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "ScrollView 2")
        }
        defaults.set(sender.isOn, forKey: "mainBox1")
        defaults.synchronize()
    }
    
    @objc private func switch1(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 1")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 1")
        }
        defaults.set(sender.isOn, forKey: "saleBox1")
        defaults.synchronize()
    }
    
    @objc private func switch2(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 2")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 2")
        }
        defaults.set(sender.isOn, forKey: "saleBox2")
        defaults.synchronize()
    }
    
    @objc private func switch3(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 3")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 3")
        }
        defaults.set(sender.isOn, forKey: "saleBox3")
        defaults.synchronize()
    }
    
    @objc private func switchMainSV2(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "ScrollView 1")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "ScrollView 1")
        }
        defaults.set(sender.isOn, forKey: "mainBox2")
        defaults.synchronize()
    }
    
    @objc private func switch4(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 4")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 4")
        }
        defaults.set(sender.isOn, forKey: "saleBox4")
        defaults.synchronize()
    }
    
    @objc private func switch5(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 5")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 5")
        }
        defaults.set(sender.isOn, forKey: "saleBox5")
        defaults.synchronize()
    }
    
    @objc private func switch6(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 6")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 6")
        }
        defaults.set(sender.isOn, forKey: "saleBox6")
        defaults.synchronize()
    }
    
    @objc private func switch7(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 7")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 7")
        }
        defaults.set(sender.isOn, forKey: "saleBox7")
        defaults.synchronize()
    }
    
    @objc private func switchMainSV3(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "ScrollView 3")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "ScrollView 3")
        }
        defaults.set(sender.isOn, forKey: "mainBox3")
        defaults.synchronize()
    }
    
    @objc private func switch8(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 8")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 8")
        }
        defaults.set(sender.isOn, forKey: "saleBox8")
        defaults.synchronize()
    }
    
    @objc private func switch9(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 9")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 9")
        }
        defaults.set(sender.isOn, forKey: "saleBox9")
        defaults.synchronize()
    }
    
    @objc private func switch10(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 10")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 10")
        }
        defaults.set(sender.isOn, forKey: "saleBox10")
        defaults.synchronize()
    }
    
    @objc private func switch11(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
            Service.uploadCellsStatus(true, "Cell 11")
        }
        else{
            print("off")
            Service.uploadCellsStatus(false, "Cell 11")
        }
        defaults.set(sender.isOn, forKey: "saleBox11")
        defaults.synchronize()
    }
}
