//
//  BoxOffice.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/24/25.
//

// https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?key=50569d2975648849c857d5379ee2c341&targetDt=20120101

import Foundation

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: BoxOffice
}

struct BoxOffice: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
}

struct DailyBoxOffice: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
