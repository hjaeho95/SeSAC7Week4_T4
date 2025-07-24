//
//  SeSACViewCellProtocol.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import Foundation

protocol SeSACViewCellProtocol: SeSACViewProtocol {
    associatedtype DataType
    
    func configuerHierarchy()
    func configureLayout()
    func configureUI(rowData: DataType)
}
