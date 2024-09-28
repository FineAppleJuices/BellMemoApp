//
//  ViewController.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 9/9/24.
//

import UIKit

class ViewController: UIViewController {
    
    // 테이블 뷰 생성
    private let tableView = UITableView()
    
    // Memo 배열 (모델 역할)
    var memos: [Memo] = [
        Memo(title: "1주차 숙제", content: "어렵다"),
        Memo(title: "2주차 숙제", content: "어려울까?"),
        Memo(title: "3주차 숙제", content: "어렵겠지")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 바 설정
        self.title = "메모 앱 숙제 리스트"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        
        // 테이블 뷰 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 테이블 뷰 셀 등록
        tableView.register(MemoTableViewCell.self, forCellReuseIdentifier: "MemoCell")
        
        // 테이블 뷰를 뷰에 추가
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addButtonTapped() {
        let addMemoVC = AddMemoViewController()
        addMemoVC.delegate = self  // Delegate 설정
        let navController = UINavigationController(rootViewController: addMemoVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    // 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    // 각 셀에 데이터를 표시하는 부분
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoTableViewCell
        
        // 메모 데이터를 셀에 전달
        let memo = memos[indexPath.row]
        cell.configure(with: memo)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    // 셀이 선택되었을 때의 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 메모를 가져옴
        let selectedMemo = memos[indexPath.row]
        
        // 메모의 상세 내용을 표시하는 뷰 컨트롤러로 이동
        let detailViewController = MemoDetailViewController()
        detailViewController.memo = selectedMemo
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: AddMemoViewControllerDelegate {
    func didAddMemo(_ memo: Memo) {
        memos.append(memo)
        tableView.reloadData()
    }
}
