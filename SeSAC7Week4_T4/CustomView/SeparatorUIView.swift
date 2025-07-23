//
//  SeparatorUIView.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import Foundation
import UIKit
import SnapKit

class SeparatorUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray
        
        self.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
