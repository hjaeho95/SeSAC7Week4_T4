//
//  UIButton+Extension.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import Foundation
import UIKit

extension UIButton {
    func setAttributedTitle(_ title: String, attributes: [NSAttributedString.Key : Any]?) {
        let attrString = NSMutableAttributedString(string: title, attributes: attributes)
        
        self.setAttributedTitle(attrString, for: .normal)
    }
}
