//
//  Lotto.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/24/25.
//

import Foundation
import Alamofire

struct Lotto: Decodable {
    
    let drwNoDate: String
    let drwNo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    
//    static func getInit() -> Int {
//        // 1181회차
//        // https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1181
//        
//        var order = 0
//        
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(1181)"
//        AF.request(url, method: .get)
//            .validate()
//            .responseDecodable(of: Lotto.self) { response in
//                switch response.result {
//                case .success(let value):
//                    dump(value)
//                    order = value.bnusNo
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        
//        return order
//    }
    
    
}
