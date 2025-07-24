//
//  BoxOfficeTableViewCell.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import UIKit
import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {

    static let identifier = "BoxOfficeTableViewCell"
    
    private var cell: UIView!
    
    private let numberLabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "말할 수 없는 비밀"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = "2007-05-07"
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cell = contentView
        
        configuerHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxOfficeTableViewCell: SeSACViewCellProtocol {
    
    func configuerHierarchy() {
        cell.addSubview(numberLabel, titleLabel, dateLabel)
    }
    
    func configureLayout() {
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(cell).offset(8)
            make.leading.equalTo(cell)
            make.bottom.equalTo(cell).offset(-8)
            make.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(numberLabel.snp.trailing).offset(16)
            make.centerY.equalTo(numberLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(cell)
            make.centerY.equalTo(numberLabel)
        }
    }
    
    func configureUI(rowData: DailyBoxOffice) {
        
        configureNumberLabel(rowData.rank)
        configureTitleLabel(rowData.movieNm)
        configureDateLabel(rowData.openDt)
    }
    
    private func configureNumberLabel(_ rank: String) {
        numberLabel.text = String(rank)
    }
    
    private func configureTitleLabel(_ title: String) {
        titleLabel.text = title
    }
    
    private func configureDateLabel(_ date: String) {
        dateLabel.text = date
    }
}
