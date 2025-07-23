//
//  LottoViewController.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import UIKit

class LottoViewController: UIViewController {

    static let identifier = "LottoViewController"
    
    let orderTextField = UITextField()
    
    let noticeLabel = UILabel()
    
    let dateLabel = UILabel()
    
    let topSeparator = UIView()
    
    let resultLabel = UILabel()
    
    let resultImageStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuerHierarchy()
        configureLayout()
        configureUI()
    }

}

extension LottoViewController: SeSACViewControllerProtocol {
    func configuerHierarchy() {
        <#code#>
    }
    
    func configureLayout() {
        <#code#>
    }
    
    func configureUI() {
        <#code#>
    }
    
    
}
