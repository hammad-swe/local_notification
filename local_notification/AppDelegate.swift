//
//  AppDelegate.swift
//  local_notification
//
//  Created by Hammad Ali on 03/08/2026.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 1. Assign delegate so foreground notifications appear
        UNUserNotificationCenter.current().delegate = self
        
        // Retrieve the active window scene from connected scenes
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = ViewController()
                self.window = window
                window.makeKeyAndVisible()
            }
        
        return true
    }

    // Show banner and play sound even when the app is in the FOREGROUND
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }

    // Respond when the user TAPS the notification banner
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        if let type = userInfo["type"] as? String, type == "water_reminder" {
            print("User clicked the water reminder notification!")
        }
        
        completionHandler()
    }
}
