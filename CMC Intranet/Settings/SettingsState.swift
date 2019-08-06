//
//  SettingsState.swift
//  CMC Intranet
//
//  Created by Dan Turner on 8/5/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

var settingsState = SettingsState() {
    didSet {
        print(settingsState)
    }
}

struct SettingsState {
    var allNotificationSettingsState = NotificationSettingState(name: "All", enabled: false)

    var notificationSettingStates = [
        NotificationSettingState(name: "One", enabled: false),
        NotificationSettingState(name: "Two", enabled: false),
        NotificationSettingState(name: "Three", enabled: false)
    ]

    var previousNotifications = [
        "First Notification",
        "Second Notification",
        "Third Notification",
        "Fourth Notification",
        "Fifth Notification"
    ]
}

struct NotificationSettingState {
    let name: String
    var enabled: Bool
}
