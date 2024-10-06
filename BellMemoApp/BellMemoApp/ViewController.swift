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
        self.tabBarItem.title = "메모"
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
    
    // 삭제 확인 알림창 표시 메서드
    func showDeleteConfirmationAlert(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "삭제 확인", message: "정말로 이 메모를 삭제하시겠습니까?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            // 메모 삭제 처리
            self.deleteMemo(at: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        // iPad 대응을 위한 설정
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.view.bounds
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // 메모 삭제 처리 메서드
    func deleteMemo(at indexPath: IndexPath) {
        // 데이터 소스에서 메모 삭제
        memos.remove(at: indexPath.row)
        // 테이블 뷰에서 행 삭제
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // 편집 화면 표시 메서드
    func presentEditMemoViewController(at indexPath: IndexPath) {
        let editMemoVC = AddMemoViewController()
        editMemoVC.delegate = self  // Delegate 설정
        editMemoVC.memoToEdit = memos[indexPath.row]
        editMemoVC.memoIndex = indexPath.row  // 편집할 메모의 인덱스 전달
        editMemoVC.isEditingMemo = true  // 편집 모드 표시
        
        let navController = UINavigationController(rootViewController: editMemoVC)
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
    
    // 스와이프 액션 추가
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // 삭제 액션 생성
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
            // 삭제 액션 선택 시 실행될 코드
            self.showDeleteConfirmationAlert(at: indexPath)
            completionHandler(true)
        }

        // 편집 액션 생성
        let editAction = UIContextualAction(style: .normal, title: "편집") { (action, view, completionHandler) in
            // 편집 액션 선택 시 실행될 코드
            self.presentEditMemoViewController(at: indexPath)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue

        // 액션 설정
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

// MARK: - AddMemoViewControllerDelegate

extension ViewController: AddMemoViewControllerDelegate {
    func didAddMemo(_ memo: Memo) {
        memos.append(memo)
        tableView.reloadData()
    }
    
    func didEditMemo(_ memo: Memo, at index: Int) {
        memos[index] = memo
        tableView.reloadData()
    }
}
