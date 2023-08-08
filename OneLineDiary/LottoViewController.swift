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

    var list: [Int] =  (1...1079).reversed() //Array(repeating: 100, count: 10)

    override func viewDidLoad() {
        super.viewDidLoad()

        print("1")
        print("2")

        callRequest(number: 1079)
        setUI()

        print("4")

        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        numberTextField.text = "\(max_number)"

        pickerView.delegate = self
        pickerView.dataSource = self

        print("5")
    }

    func callRequest(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)
                let date = json["drwNoDate"].stringValue
                let bonusNumber = json["bnusNo"].intValue
                var pickedNumber: [Int] = []

                self.bonusNumberLabel.text = "\(bonusNumber)"

                switch bonusNumber {
                case 1...10:
                    self.bonusNumberLabel.backgroundColor = .yellow
                case 11...20:
                    self.bonusNumberLabel.backgroundColor = .blue
                case 21...30:
                    self.bonusNumberLabel.backgroundColor = .red
                case 31...40:
                    self.bonusNumberLabel.backgroundColor = .gray
                case 41...45:
                    self.bonusNumberLabel.backgroundColor = .green
                default:
                    break
                }

                for i in 1...6 {
                    let number = json["drwtNo\(i)"].intValue
                    pickedNumber.append(number)
                }

                for i in 0..<pickedNumber.count {
                    switch pickedNumber[i] {
                    case 1...10:
                        self.pickedNumberLabel[i].backgroundColor = .yellow
                    case 11...20:
                        self.pickedNumberLabel[i].backgroundColor = .blue
                    case 21...30:
                        self.pickedNumberLabel[i].backgroundColor = .red
                    case 31...40:
                        self.pickedNumberLabel[i].backgroundColor = .gray
                    case 41...45:
                        self.pickedNumberLabel[i].backgroundColor = .green
                    default:
                        break
                    }
                    self.pickedNumberLabel[i].text = "\(pickedNumber[i])"
                }

                self.dateLabel.text = date
                //self.bonusNumberLabel.text = "\(bonusNumber)번"

            case .failure(let error):
                print(error)
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("select \(row)")
        callRequest(number: list[row])
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
