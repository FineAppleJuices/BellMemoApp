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
    
    // 메모 제목을 표시할 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20) // 제목은 굵은 글씨로 설정
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 메모 내용을 표시할 레이블
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 여러 줄 표시 가능하도록 설정
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
        // 레이블을 뷰에 추가
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // 제목 레이블 레이아웃
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // 내용 레이블 레이아웃
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        // 메모 내용 표시
        if let memo = memo {
            titleLabel.text = memo.title
            contentLabel.text = memo.content
        }
    }
}
