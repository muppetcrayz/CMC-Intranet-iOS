//
//  SettingsViewController.swift
//  CMC Intranet
//
//  Created by Dan Turner on 8/5/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    let notificationSettingCellID = "notificationSettingCellID"
    let previousNotificationCellID = "previousNotificationCellID"

    let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        with(tableView) {
            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalToSuperview()
            }
            
            $0.dataSource = self

            $0.register(SettingsTableViewCell.self, forCellReuseIdentifier: notificationSettingCellID)
            $0.register(UITableViewCell.self, forCellReuseIdentifier: previousNotificationCellID)

            $0.allowsSelection = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(donePressed)
            )
        }
    }

    @objc func donePressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: notificationSettingCellID, for: indexPath) as! SettingsTableViewCell

            cell.valueChangedActions = []

            switch indexPath.row {
            case 0:
                cell.label.text = settingsState.allNotificationSettingsState.name
                cell.enabledSwitch.isOn = settingsState.allNotificationSettingsState.enabled

                cell.valueChangedActions.append({ enabled in
                    settingsState.allNotificationSettingsState.enabled = enabled
                    settingsState.notificationSettingStates = settingsState.notificationSettingStates.map {
                        NotificationSettingState(
                            name: $0.name,
                            enabled: enabled
                        )
                    }
                })

            default:
                let notificationState = settingsState.notificationSettingStates[indexPath.row - 1]

                cell.label.text = notificationState.name
                cell.enabledSwitch.isOn = notificationState.enabled

                cell.valueChangedActions.append({
                    settingsState.notificationSettingStates[indexPath.row - 1].enabled = $0

                    settingsState.allNotificationSettingsState.enabled = settingsState.notificationSettingStates.allSatisfy { $0.enabled }
                })
            }

            cell.valueChangedActions.append({ _ in
                UIView.transition(
                    with: tableView,
                    duration: 0.33,
                    options: [.transitionCrossDissolve, .allowUserInteraction],
                    animations: {
                        tableView.reloadData()
                },
                    completion: .none
                )
            })

            cell.valueChangedActions.append({ switchOn in
                let allTopics: [String] = [
                    "announcements",
                    "documents",
                    "companynews",
                    "jobopenings"
                ]

                let topics: [String]

                switch(indexPath.row) {
                case 0:
                    topics = allTopics

                default:
                    topics = [allTopics[indexPath.row - 1]]
                }

                topics.forEach { topic in
                    if switchOn {
                        Messaging.messaging().subscribe(toTopic: topic) { error in
                            print("Subscribed to \(topic) topic")
                        }
                    }
                    else {
                        Messaging.messaging().unsubscribe(fromTopic: topic) { error in
                            print("Unsubscribed from \(topic) topic")
                        }
                    }
                }
            })

            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: previousNotificationCellID, for: indexPath)

            cell.textLabel?.text = previousNotifications.reversed()[indexPath.row]

            return cell

        default: fatalError("code should not reach this point")
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return settingsState.notificationSettingStates.count + 1
        case 1: return previousNotifications.count
        default: fatalError("code should not reach this point")
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Notification Settings"
        case 1: return "Previous Notifications"
        default: fatalError("code should not reach this point")
        }
    }
}
