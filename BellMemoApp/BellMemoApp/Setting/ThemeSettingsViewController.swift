//
//  ThemeSettingsViewController.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 10/7/24.
//

import UIKit

class ThemeSettingsViewController: UIViewController {

    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["라이트", "다크", "시스템"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "테마 설정"
        view.backgroundColor = .white

        // 저장된 설정 값 로드
        let selectedTheme = UserDefaults.standard.integer(forKey: "selectedTheme")
        segmentedControl.selectedSegmentIndex = selectedTheme
//
//        // 세그먼트 값 변경 시 동작 설정
//        segmentedControl.addTarget(self, action: #selector(themeSegmentChanged(_:)), for: .valueChanged)

        // 세그먼트 컨트롤 추가 및 오토레이아웃 설정
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

//    @objc private func themeSegmentChanged(_ sender: UISegmentedControl) {
//        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "selectedTheme")
//        // 테마 변경 적용
//        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
//            sceneDelegate.applyTheme()
//        }
//    }
}
