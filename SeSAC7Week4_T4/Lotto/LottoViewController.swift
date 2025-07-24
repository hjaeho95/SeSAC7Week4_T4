//
//  LottoViewController.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class LottoViewController: UIViewController {
    
    // MARK: - Identifier
    static let identifier = "LottoViewController"
    
    // MARK: - Properties
    var order: Int = 1181 {
        didSet {
            getData(order: order)
        }
    }
    
    var numberRange: [Int] = Array(1...1181).reversed()
    
    var lotto: Lotto = Lotto(drwNoDate: "", drwNo: 0, drwtNo1: 0, drwtNo2: 0, drwtNo3: 0, drwtNo4: 0, drwtNo5: 0, drwtNo6: 0, bnusNo: 0) {
        didSet {
            lottoNumbers = [ lotto.drwtNo1, lotto.drwtNo2, lotto.drwtNo3, lotto.drwtNo4, lotto.drwtNo5, lotto.drwtNo6, lotto.bnusNo ]
            selectOrder()
        }
    }
    
    var lottoNumbers: [Int] = []
    
    // MARK: - Components
    let numberPicker = UIPickerView()
    
    lazy var orderTextField = {
        let textField = UITextField()
        textField.placeholder = "당첨 회차를 선택하세요."
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.inputView = numberPicker
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
        return label
    }()
    
    let resultStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let plusLabel = {
        let label = UILabel()
        label.text = "+"
        label.textAlignment = .center
        return label
    }()
    
    var resultViews: [UIView] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configuerHierarchy()
        configureLayout()
        configureUI()
        
        getData(order: order)
    }
    
    // MARK: - Method
    func configure() {
        numberPicker.delegate = self
        numberPicker.dataSource = self
    }
    
    func selectOrder() {
        configureOrderTextField()
        configureNumberUIView()
        configureDateLabel()
        configureResultLabel()
    }
    
    func getData(order: Int) {
        // 1181회차
        // https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1181
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(order)"
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let data):
                    self.lotto = data
                case .failure(let error):
                    print(error)
                }
            }
    }

}

extension LottoViewController: SeSACViewControllerProtocol {
    // MARK: - Configure Hierarchy
    func configuerHierarchy() {
        view.addSubview(orderTextField, noticeLabel, dateLabel, topSeparator, resultLabel, resultStackView)
        
        for i in 1...8 {
            if i == 7 {
                // 공 타이틀 +, 배경 흰색
                resultStackView.addArrangedSubview(plusLabel)
                continue
            }
            let numberUIView = initNumberUIView()
            resultStackView.addArrangedSubview(numberUIView)
            resultViews.append(numberUIView)
        }
    }
    
    // MARK: - Configure Constraints
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
        
        resultStackView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(30)
        }
        
        plusLabel.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
    }
    
    // MARK: - Configure UI
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func initNumberUIView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray
        
        view.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        
        view.addSubview(initNumberLabel())
        return view
    }
    
    func initNumberLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        DispatchQueue.main.async {
            label.snp.makeConstraints { make in
                make.size.equalTo(30)
            }
        }
        return label
    }
    
    func configureOrderTextField() {
        orderTextField.text = String(order)
    }
    
    func configureNumberUIView() {
        for i in 0..<resultViews.count {
            let number = lottoNumbers[i]
            let label = resultViews[i].subviews[0] as? UILabel
            label?.text = String(number)
            
            resultViews[i].backgroundColor = switch number {
            case 1..<10:
                    .systemRed
            case 10..<20:
                    .systemBlue
            case 20..<30:
                    .systemCyan
            case 30..<40:
                    .systemOrange
            default:
                    .systemGray
            }
        }
    }
    
    func configureDateLabel() {
        dateLabel.text = "\(lotto.drwNoDate) 추첨"
    }
    
    func configureResultLabel() {
        resultLabel.text = "\(lotto.drwNo)회 당첨결과"
    }
}

// MARK: - NumberPicker
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        order = numberRange[row]
    }
}
