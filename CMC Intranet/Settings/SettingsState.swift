//
//  SettingsState.swift
//  CMC Intranet
//
//  Created by Dan Turner on 8/5/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

var previousNotifications: [String] = []

var settingsState = SettingsState() {
    didSet {
        print(settingsState)
    }
}

struct SettingsState {
    var allNotificationSettingsState = NotificationSettingState(name: "All", enabled: false)

    var notificationSettingStates = [
        NotificationSettingState(name: "Announcements", enabled: false),
        NotificationSettingState(name: "Documents", enabled: false),
        NotificationSettingState(name: "Company News", enabled: false),
        NotificationSettingState(name: "Job Openings", enabled: false)
    ]

}

struct NotificationSettingState {
    let name: String
    var enabled: Bool
}
