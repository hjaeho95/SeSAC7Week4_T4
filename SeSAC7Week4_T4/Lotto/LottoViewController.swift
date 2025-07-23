//
//  LottoViewController.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {

    static let identifier = "LottoViewController"
    
    var order = 0
    
    let numberRange = Array(1...1000)
    
    let numberPicker = UIPickerView()
    
    let orderTextField = {
        let textField = UITextField()
        textField.placeholder = "당첨 회차를 선택하세요."
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    let noticeLabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.text = "2020-05-30 추첨"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    let topSeparator = {
        let separator = SeparatorUIView()
        return separator
    }()
    
    let resultLabel = {
        let label = UILabel()
        label.text = "당첨결과"
        label.font = .systemFont(ofSize: 24, weight: .bold)
//        label.textColor =
        return label
    }()
    
    let resultImageStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configuerHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configure() {
        numberPicker.delegate = self
        numberPicker.dataSource = self
    }
}

extension LottoViewController: SeSACViewControllerProtocol {
    func configuerHierarchy() {
        view.addSubview(orderTextField)
        view.addSubview(noticeLabel)
        view.addSubview(dateLabel)
        view.addSubview(topSeparator)
        view.addSubview(resultLabel)
        view.addSubview(resultImageStackView)
        
        for i in 1...8 {
            resultImageStackView.addArrangedSubview(setNumberUIView())
        }
    }
    
    func configureLayout() {
        orderTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(orderTextField.snp.bottom).offset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(noticeLabel)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        topSeparator.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(topSeparator.snp.bottom).offset(24)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        resultImageStackView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(30)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        orderTextField.inputView = numberPicker
    }
    
    func setNumberUIView() -> UIView {
        let view = UIView()
        view.backgroundColor = .orange
        
        view.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        
        view.addSubview(
            {
                let label = UILabel()
                label.text = String(Int.random(in: 1...45))
                label.font = .systemFont(ofSize: 18, weight: .bold)
                label.textColor = .white
                label.textAlignment = .center
                
                DispatchQueue.main.async {
                    label.snp.makeConstraints { make in
                        make.size.equalTo(view)
                    }
                }
                return label
            }()
        )
        return view
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberRange.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(numberRange[row])
    }
}
