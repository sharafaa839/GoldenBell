//
//  AppDelegate.swift
//  Mazadaat
//
//  Created by macbook on 10/11/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Firebase
import FirebaseCore
import FirebaseMessaging
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import SwiftyStoreKit
import UIKit
import UserNotifications

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private(set) lazy var coordinator = AppCoordinator()
    let gcmMessageIDKey = "gcm.Message_IDKey"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        setupIAP()
        LocalizationManager.shared.setAppInnitLanguage()
        LocalizationManager.shared.delegate = self
        AppUtilities.changeRoot(root: SplashViewController(viewModel: SplashViewModel()))
        GMSPlacesClient.provideAPIKey("AIzaSyDR4OvW6PYXeKL5iq_TpEDbHzeq4SajVQc")
        GMSServices.provideAPIKey("AIzaSyDR4OvW6PYXeKL5iq_TpEDbHzeq4SajVQc")

        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // Check if the user came from a universal link.
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            // Get the URL of the universal link.
            let url = userActivity.webpageURL

            // Check if the URL is for the profile page.
            if (url?.path.contains("auction")) != nil {
                // Navigate to the auction details page.
            }
        }
        // Return true to indicate that the universal link was handled.
        return true
    }

    func configureIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        IQKeyboardManager.shared.keyboardAppearance = .default
        IQKeyboardManager.shared.toolbarTintColor = .Bronze_500
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "done"
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
    }

    func setupIAP() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in

            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    let downloads = purchase.transaction.downloads
                    if !downloads.isEmpty {
                        SwiftyStoreKit.start(downloads)
                    } else if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    print("\(purchase.transaction.transactionState.debugDescription): \(purchase.productId)")
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break // do nothing
                }
            }
        }

        SwiftyStoreKit.updatedDownloadsHandler = { downloads in

            // contentURL is not nil if downloadState == .finished
            let contentURLs = downloads.compactMap { $0.contentURL }
            if contentURLs.count == downloads.count {
                print("Saving: \(contentURLs)")
                SwiftyStoreKit.finishTransaction(downloads[0].transaction)
            }
        }
    }
}

extension AppDelegate: LocalizationManagerDelegate {
    func resetApp() {
        print("local")
        AppUtilities.changeRoot(root: UINavigationController(rootViewController: SplashViewController(viewModel: SplashViewModel())))
    }
}
