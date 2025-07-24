//
//  BoxOfficeEasyViewController.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/24/25.
//

import UIKit
import SnapKit
import Alamofire

final class BoxOfficeEasyViewController: UIViewController {

    // MARK: Identifier
    static let identifier: String = "BoxOfficeEasyViewController"
    
    private var data: [DailyBoxOffice] = [] {
        didSet {
            configureUI()
        }
    }
    
    // MARK: Components
    private let textField = {
        let textField = UITextField()
        textField.text = "20250723"
        textField.textAlignment = .center
        return textField
    }()
    
    private let label1 = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let label2 = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let label3 = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let label4 = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let label5 = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let label6 = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let label7 = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let label8 = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let label9 = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configuerHierarchy()
        configureLayout()
        configure()
        
        getData("20250723")
    }
}

extension BoxOfficeEasyViewController: SeSACViewControllerProtocol {
    func configuerHierarchy() {
        view.addSubview(textField, label1, label2, label3, label4, label5, label6, label7, label8, label9)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        label1.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        label3.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        label4.snp.makeConstraints { make in
            make.top.equalTo(label3.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        label5.snp.makeConstraints { make in
            make.top.equalTo(label4.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        label6.snp.makeConstraints { make in
            make.top.equalTo(label5.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        label7.snp.makeConstraints { make in
            make.top.equalTo(label6.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        label8.snp.makeConstraints { make in
            make.top.equalTo(label7.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        label9.snp.makeConstraints { make in
            make.top.equalTo(label8.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
    }
    
    func configureUI() {
        label1.text = data[0].rank
        label2.text = data[0].movieNm
        label3.text = data[0].openDt
        label4.text = data[1].rank
        label5.text = data[1].movieNm
        label6.text = data[1].openDt
        label7.text = data[2].rank
        label8.text = data[2].movieNm
        label9.text = data[2].openDt
    }
    
    func configure() {
        textField.delegate = self
    }
    
    // MARK: - Method
    
    // MARK: - Network
    func getData(_ date: String) {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=50569d2975648849c857d5379ee2c341&targetDt=\(date)#"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
//            .responseString { response in
//                switch response.result {
//                case .success(let data):
//                    dump(data)
//                case .failure(let error):
//                    print(error)
//                }
//                
//            }
            .responseDecodable(of: BoxOfficeResult.self) { response in
                switch response.result {
                case .success(let data):
                    self.data = data.boxOfficeResult.dailyBoxOfficeList
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension BoxOfficeEasyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        guard let text = textField.text else { return true }
        getData(text)
        return true
    }
}
