//
//  SeSACTableViewControllerProtocol.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import Foundation
import UIKit

protocol SeSACTableViewControllerProtocol: SeSACViewControllerProtocol, UITableViewDelegate, UITableViewDataSource {
    func configure()
}
