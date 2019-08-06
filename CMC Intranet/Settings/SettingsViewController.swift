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

            switch indexPath.row {
            case 0:
                cell.label.text = "All"
                cell.enabledSwitch.isOn = settingsState.allNotificationSettingsState.enabled

                cell.switchHandler = { enabled in
                    settingsState.allNotificationSettingsState.enabled = enabled
                    settingsState.notificationSettingStates = settingsState.notificationSettingStates.map {
                        NotificationSettingState(
                            name: $0.name,
                            enabled: enabled
                        )
                    }

                    UIView.transition(
                        with: tableView,
                        duration: 0.33,
                        options: [.transitionCrossDissolve, .allowUserInteraction],
                        animations: {
                            tableView.reloadData()
                        },
                        completion: .none
                    )
                }
                
                Messaging.messaging().subscribe(toTopic: "announcements") { error in
                    print("Subscribed to announcements topic")
                }
            
                Messaging.messaging().subscribe(toTopic: "documents") { error in
                    print("Subscribed to documents topic")
                }
            
                Messaging.messaging().subscribe(toTopic: "companynews") { error in
                    print("Subscribed to companynews topic")
                }
            
                Messaging.messaging().subscribe(toTopic: "jobopenings") { error in
                    print("Subscribed to jobopenings topic")
                }

            default:
                let notificationState = settingsState.notificationSettingStates[indexPath.row - 1]

                cell.label.text = notificationState.name
                cell.enabledSwitch.isOn = notificationState.enabled

                cell.switchHandler = {
                    settingsState.notificationSettingStates[indexPath.row - 1].enabled = $0

                    settingsState.allNotificationSettingsState.enabled = settingsState.notificationSettingStates.allSatisfy { $0.enabled }

                    UIView.transition(
                        with: tableView,
                        duration: 0.33,
                        options: [.transitionCrossDissolve, .allowUserInteraction],
                        animations: {
                            tableView.reloadData()
                        },
                        completion: .none
                    )
                    
                    switch(indexPath.row - 1) {
                    case 0:
                        Messaging.messaging().subscribe(toTopic: "announcements") { error in
                            print("Subscribed to announcements topic")
                        }
                        break
                    case 1:
                        Messaging.messaging().subscribe(toTopic: "documents") { error in
                            print("Subscribed to documents topic")
                        }
                        break
                    case 2:
                        Messaging.messaging().subscribe(toTopic: "companynews") { error in
                            print("Subscribed to companynews topic")
                        }
                        break
                    case 3:
                        Messaging.messaging().subscribe(toTopic: "jobopenings") { error in
                            print("Subscribed to jobopenings topic")
                        }
                        break
                    default:
                        break
                    }
                }
            }

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
