//
//  UIView+Extension.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import Foundation
import UIKit

extension UIView {
    func addSubview(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
