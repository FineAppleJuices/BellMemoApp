//
//  AddMemoViewController.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 9/28/24.
//

import UIKit

protocol AddMemoViewControllerDelegate: AnyObject {
    func didAddMemo(_ memo: Memo)
}

class AddMemoViewController: UIViewController {
    
    weak var delegate: AddMemoViewControllerDelegate?
    
    // UI 요소들
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 네비게이션 바 설정
        navigationItem.title = "메모 추가"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .done,
            target: self,
            action: #selector(saveButtonTapped)
        )
        
        // 서브뷰 추가
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)

        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // titleTextField 제약 조건은 그대로 유지
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // contentTextView 제약 조건
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let content = contentTextView.text, !content.isEmpty else {
            // 제목이나 내용이 비어 있을 경우 알림 표시
            let alert = UIAlertController(title: "오류", message: "제목과 내용을 입력하세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        
        let newMemo = Memo(title: title, content: content)
        delegate?.didAddMemo(newMemo)
        dismiss(animated: true, completion: nil)
    }
}
