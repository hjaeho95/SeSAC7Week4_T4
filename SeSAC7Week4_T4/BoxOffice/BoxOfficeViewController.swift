//
//  BoxOfficeViewController.swift
//  SeSAC7Week4_T4
//
//  Created by ez on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class BoxOfficeViewController: UIViewController {

    // MARK: - Identifier
    static let identifier = "BoxOfficeViewController"
    
    // MARK: - Property
    private var data: [DailyBoxOffice] = [] {
        didSet {
            tableView.reloadData()
            searchTextField.text = ""
            view.endEditing(true)
        }
    }
    
    // MARK: - Component
    let searchTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let searchButton = {
        let button = UIButton()
        button.setAttributedTitle("검색", attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
            .foregroundColor: UIColor.black.cgColor
        ])
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let tableView = UITableView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configuerHierarchy()
        configureLayout()
        configureUI()
        
        if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) { search(yesterday.formattedString(format: "yyyyMMdd"))
        }
    }
    
    // MARK: - Method
    @objc func searchButtonTapped() {
        guard let date = searchTextField.text else { return }
        
        search(date)
    }
    
    // MARK: - Network
    private func search(_ date: String) {
        
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=50569d2975648849c857d5379ee2c341&targetDt=\(date)#"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
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

extension BoxOfficeViewController: SeSACTableViewControllerProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as! BoxOfficeTableViewCell
        
        let rowData = data[indexPath.row]
        
        cell.configureUI(rowData: rowData)
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        
        tableView.rowHeight = 40
        
        searchTextField.delegate = self
    }
    
    func configuerHierarchy() {
        view.addSubview(searchTextField, searchButton, tableView)
    }
    
    func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(searchButton.snp.leading).offset(-16)
            make.height.equalTo(50)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextField)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .gray
        tableView.backgroundColor = .clear
    }
}

extension BoxOfficeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        search(text)
        return true
    }
}
