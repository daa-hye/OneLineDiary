//
//  LottoAPIManager.swift
//  OneLineDiary
//
//  Created by 박다혜 on 2023/09/13.
//

import Foundation
import Alamofire

class LottoAPIManager {

    static let shared = LottoAPIManager()
    private init() {}

    func request(number: Int, completionHandler: @escaping (LottoResult) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: LottoResult.self ,completionHandler: { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            })





    }

}
