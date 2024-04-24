//
//  PushNotifications.swift
//
//  Created by abdullah tarek
//

import Firebase
import FirebaseMessaging
import UserNotifications

extension AppDelegate: MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        AppData.fcmToken = fcmToken ?? ""
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
    }

    // MARK: - Handel the arrived Notifications

    // Use this method to process incoming remote notifications for your app
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }

    // when the notification arrives and the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        UIApplication.shared.applicationIconBadgeNumber += 1

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        if #available(iOS 14.0, *) {
            completionHandler([.sound, .badge, .list, .banner])
        } else {
            completionHandler([.sound, .badge])
        }

        print("Notification info is: \n\(userInfo)")

        guard let id = userInfo["ref_id"] as? String else { return }
        guard let type = userInfo["type"] as? String else { return }
        guard let price = userInfo["price"] as? String else { return }
        guard let userID = userInfo["user_id"] as? String else { return }

        if let typeInt = Int(type),
           typeInt == 6 {
            let dic = [
                "id": id,
                "price": price,
                "user_id": userID,
            ]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateBid"), object: nil,userInfo: dic as [AnyHashable: Any])
        }
    }

    // when the user tap on the notification banar
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
    }
}
