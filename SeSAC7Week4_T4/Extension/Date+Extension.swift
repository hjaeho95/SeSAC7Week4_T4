//
//  Date+Extension.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/24/25.
//

import Foundation

extension Date {
    func formattedString(format: String) -> String {
        let date = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
}
