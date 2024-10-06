//
//  SettingsViewController.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 10/7/24.
//
import UIKit

class SettingsViewController: UITableViewController {

    // 설정 항목 정의
    enum SettingItem: Int, CaseIterable {
        case notification
        case theme
        case appInfo

        var title: String {
            switch self {
            case .notification:
                return "알림 설정"
            case .theme:
                return "테마 설정"
            case .appInfo:
                return "앱 정보"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 네비게이션 바 설정
        self.title = "설정"

        // 테이블 뷰 설정
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // 섹션 수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // 행의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingItem.allCases.count
    }

    // 셀 구성
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let settingItem = SettingItem(rawValue: indexPath.row) else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = settingItem.title
        cell.accessoryType = .disclosureIndicator // 셀의 우측에 화살표 표시
        return cell
    }

    // 셀 선택 시 동작
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let settingItem = SettingItem(rawValue: indexPath.row) else { return }
        tableView.deselectRow(at: indexPath, animated: true)

        switch settingItem {
        case .notification:
            // 알림 설정 상세 화면으로 이동
            let notificationSettingsVC = NotificationSettingsViewController()
            navigationController?.pushViewController(notificationSettingsVC, animated: true)

        case .theme:
            // 테마 설정 상세 화면으로 이동
            let themeSettingsVC = ThemeSettingsViewController()
            navigationController?.pushViewController(themeSettingsVC, animated: true)

        case .appInfo:
            // 앱 정보 화면으로 이동
            let appInfoVC = AppInfoViewController()
            navigationController?.pushViewController(appInfoVC, animated: true)
        }
    }
}
