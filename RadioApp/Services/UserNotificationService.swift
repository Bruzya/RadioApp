//
//  UserNotificationService.swift
//  RadioApp
//
//  Created by dsm 5e on 06.08.2024.
//

import Foundation
import UserNotifications

final class UserNotificationService {

    static let shared = UserNotificationService()

    private init() {}

    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                completion(granted, error)
            }
    }

    func scheduleDailyNotification(at time: Date) {
        let content = UNMutableNotificationContent()
        content.title = String.localize(key: "reminder")
        content.body = String.localize(key: "reminderDescriptions")
        content.sound = .default

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)

        /// Добавление запроса в центр уведомлений
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            } else {
                print("Уведомление успешно запланировано")
            }
        }
    }
}
