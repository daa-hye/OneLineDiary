//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 박다혜 on 2023/08/03.
//

import UIKit
import SwiftyJSON
import Alamofire

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var pickedNumberLabel: [UILabel]!
    @IBOutlet var bonusNumberLabel: UILabel!

    let pickerView = UIPickerView()
    let max_number = 1079

    var list: [Int] = (1...1079).reversed() //Array(repeating: 100, count: 10)

    let model = LottoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        //print("1")
        //print("2")

        setUI()

        //print("4")

        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        numberTextField.text = "\(max_number)"

        pickerView.delegate = self
        pickerView.dataSource = self

        let numbers = model.pickedNumbers
        for i in 0..<numbers.count {
            numbers[i].bind {
                self.pickedNumberLabel[i].text = "\($0!)"

                let color = self.model.setColor(number: i)
                self.pickedNumberLabel[i].backgroundColor = UIColor(named: color)

            }
        }

        model.bonusNumber.bind {
            self.bonusNumberLabel.text = "\($0!)"
            let color = self.model.setColor()
            self.bonusNumberLabel.backgroundColor = UIColor(named: color)
        }

        model.date.bind {
            self.dateLabel.text = $0
        }

        //print("5")
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        model.loadNumber(list[row])
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }

    func setUI() {
        for item in pickedNumberLabel {
            item.layer.cornerRadius = 20
            item.clipsToBounds = true
            item.textAlignment = .center
        }

        bonusNumberLabel.layer.cornerRadius = 20
        bonusNumberLabel.textAlignment = .center
        bonusNumberLabel.clipsToBounds = true
    }

}
