//
//  AppInfoViewController.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 10/7/24.
//
import UIKit

class AppInfoViewController: UIViewController {

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "이 앱은 메모 앱입니다.\n버전 1.0.0"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "앱 정보"
        view.backgroundColor = .white

        // 레이블 추가 및 오토레이아웃 설정
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
