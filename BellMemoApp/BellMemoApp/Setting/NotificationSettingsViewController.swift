//
//  NotificationSettingsViewController.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 10/7/24.
//
import UIKit

class NotificationSettingsViewController: UIViewController {

    // "알림 켜기" 레이블 생성
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "알림 켜기"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // 알림 설정 스위치 생성
    private let notificationSwitch: UISwitch = {
        let notificationSwitch = UISwitch()
        notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        return notificationSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 네비게이션 바 제목 설정
        self.title = "알림 설정"
        view.backgroundColor = .white

        // 저장된 설정 값 로드
        let isNotificationEnabled = UserDefaults.standard.bool(forKey: "isNotificationEnabled")
        notificationSwitch.isOn = isNotificationEnabled

        // 스위치 값 변경 시 동작 설정
        notificationSwitch.addTarget(self, action: #selector(notificationSwitchChanged(_:)), for: .valueChanged)

        // 레이블과 스위치를 포함하는 스택 뷰 생성
        let stackView = UIStackView(arrangedSubviews: [titleLabel, notificationSwitch])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // 스택 뷰를 뷰에 추가
        view.addSubview(stackView)

        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // 스택 뷰를 뷰의 중앙에 배치
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func notificationSwitchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isNotificationEnabled")
        // 필요에 따라 추가 작업 수행
    }
}
