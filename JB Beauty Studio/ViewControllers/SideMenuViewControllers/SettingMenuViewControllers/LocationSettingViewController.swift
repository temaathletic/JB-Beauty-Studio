//
//  LocationSettingViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import SnapKit

class LocationSettingViewController: UIViewController {
    
    var currentCity: String = ""
    
    let pickerArray = ["Армавир", "Ростов на Дону", "Краснодар"]
    
    private let picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var saveBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(Color.mainTextColor, for: .normal)
        button.backgroundColor = Color.mainRedColor
        button.addTarget(self, action: #selector(saveTap), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    @objc private func saveTap() {
        Service.updateUserLocation(location: currentCity)
        navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.mainBackgroundColor
        let backButton = UIBarButtonItem()
        backButton.title = ""
        
        title = "Местоположение"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = Color.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Color.mainTextColor!]
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let row = UserDefaults.standard.integer(forKey: "pickerViewRow")
        picker.selectRow(row, inComponent: 0, animated: false)
        picker.dataSource = self
        picker.delegate = self
        
        view.addSubview(saveBtn)
        view.addSubview(picker)
        
        picker.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        saveBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}

extension LocationSettingViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < pickerArray.count else {
            UserDefaults.standard.set(row, forKey: "pickerViewRow")
            return
    }
        currentCity = pickerArray[row]
}
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
}

extension LocationSettingViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        picker.tintColor = Color.mainTextColor
        currentCity = pickerArray[row]
        return pickerArray[row]
    }
    
}


