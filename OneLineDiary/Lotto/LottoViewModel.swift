//
//  LottoViewModel.swift
//  OneLineDiary
//
//  Created by 박다혜 on 2023/09/13.
//

import Foundation

class LottoViewModel {

    private let lottoManager = LottoAPIManager.shared

    var pickedNumbers: [Observable<Int?>] = [Observable(0),Observable(0),Observable(0),Observable(0),Observable(0),Observable(0)]
    var bonusNumber:Observable<Int?> = Observable(0)
    var date:Observable<String?> = Observable("")

    func loadNumber(_ drawNumber: Int) {

        lottoManager.request(number: drawNumber) { results in
            var numbers: [Int] = []
            numbers.append(results.drwtNo1)
            numbers.append(results.drwtNo2)
            numbers.append(results.drwtNo3)
            numbers.append(results.drwtNo4)
            numbers.append(results.drwtNo5)
            numbers.append(results.drwtNo6)

            for i in 0..<numbers.count {
                self.pickedNumbers[i].value = numbers[i]
            }
            self.bonusNumber.value = results.bnusNo
            self.date.value = results.drwNoDate
        }

    }

    func setColor(number: Int) -> String {
        switch pickedNumbers[number].value! {
        case 1...10:
            return "yellow"
        case 11...20:
            return "blue"
        case 21...30:
            return "red"
        case 31...40:
            return "gray"
        case 41...45:
            return "green"
        default:
            return "clear"
        }
    }

    func setColor() -> String {
        switch bonusNumber.value! {
        case 1...10:
            return "yellow"
        case 11...20:
            return "blue"
        case 21...30:
            return "red"
        case 31...40:
            return "gray"
        case 41...45:
            return "green"
        default:
            return "clear"
        }
    }
    
}
