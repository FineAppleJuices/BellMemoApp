//
//  AddMemoViewController.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 9/28/24.
//

import UIKit

protocol AddMemoViewControllerDelegate: AnyObject {
    func didAddMemo(_ memo: Memo)
    func didEditMemo(_ memo: Memo, at index: Int)
}

class AddMemoViewController: UIViewController {
    
    weak var delegate: AddMemoViewControllerDelegate?
    
    var memoToEdit: Memo?
    var memoIndex: Int?
    var isEditingMemo: Bool = false
    
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
        if isEditingMemo {
            navigationItem.title = "메모 편집"
        } else {
            navigationItem.title = "메모 추가"
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: isEditingMemo ? "확인" : "저장",
            style: .done,
            target: self,
            action: #selector(saveButtonTapped)
        )

        // 서브뷰 추가
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)

        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // titleTextField 제약 조건
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // contentTextView 제약 조건
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])

        // 편집 모드일 경우 기존 메모의 내용을 표시
        if isEditingMemo, let memo = memoToEdit {
            titleTextField.text = memo.title
            contentTextView.text = memo.content
        }
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

        if isEditingMemo {
            // 편집 모드인 경우 기존 메모를 업데이트
            memoToEdit?.title = title
            memoToEdit?.content = content
            if let index = memoIndex, let updatedMemo = memoToEdit {
                delegate?.didEditMemo(updatedMemo, at: index)
            }
        } else {
            // 새 메모 추가
            let newMemo = Memo(title: title, content: content)
            delegate?.didAddMemo(newMemo)
        }

        dismiss(animated: true, completion: nil)
    }
}
