//
//  MemoDetailViewController.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 9/21/24.
//

import UIKit

class MemoDetailViewController: UIViewController {
    
    // 표시할 메모
    var memo: Memo?
    
    // 메모 내용을 표시할 레이블
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 설정
        view.backgroundColor = .white
        
        // 메모 제목을 네비게이션 바 제목으로 설정
        self.title = memo?.title
        
        // 레이블 추가
        view.addSubview(memoLabel)
        
        // 레이블 레이아웃 설정
        NSLayoutConstraint.activate([
            memoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            memoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            memoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        // 메모 내용 표시
        if let memo = memo {
            memoLabel.text = memo.content
        }
    }
}
