//
//  LottoResult.swift
//  OneLineDiary
//
//  Created by 박다혜 on 2023/09/13.
//

import Foundation

struct LottoResult: Codable {

    let drwNoDate: String
    let drwNo: Int
    let drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6: Int
    let bnusNo: Int

}
