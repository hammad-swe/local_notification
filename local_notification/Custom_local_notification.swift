//
//  Custom_local_notification.swift
//  local_notification
//
//  Created by Hammad Ali on 04/08/2026.
//

//import UIKit
//import UserNotifications
//
//class Custom_local_notification: UIViewController, UNUserNotificationCenterDelegate {
//
//    // MARK: - UI Components
//    private let statusLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Tap 'Setup Categories' to begin."
//        label.font = .systemFont(ofSize: 16, weight: .medium)
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        return label
//    }()
//
//    private let setupCategoriesButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("1. Setup Categories & Ask Permission", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
//        button.backgroundColor = .systemBlue
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        return button
//    }()
//
//    private let scheduleActionButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("2. Trigger Action Notification (5s)", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
//        button.backgroundColor = .systemGreen
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        return button
//    }()
//
//    private let scheduleTextInputButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("3. Trigger Reply Notification (5s)", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
//        button.backgroundColor = .systemOrange
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        return button
//    }()
//
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//
//        // Set delegate to handle actions within this ViewController
//        UNUserNotificationCenter.current().delegate = self
//
//        setupLayout()
//        setupButtonActions()
//    }
//
//    // MARK: - Layout Setup
//    private func setupLayout() {
//        let stackView = UIStackView(arrangedSubviews: [
//            statusLabel,
//            setupCategoriesButton,
//            scheduleActionButton,
//            scheduleTextInputButton
//        ])
//        stackView.axis = .vertical
//        stackView.spacing = 16
//        stackView.distribution = .fillEqually
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(stackView)
//
//        NSLayoutConstraint.activate([
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
//            setupCategoriesButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//
//    private func setupButtonActions() {
//        setupCategoriesButton.addTarget(self, action: #selector(registerCategoriesAndPermission), for: .touchUpInside)
//        scheduleActionButton.addTarget(self, action: #selector(scheduleActionButtonNotification), for: .touchUpInside)
//        scheduleTextInputButton.addTarget(self, action: #selector(scheduleTextInputNotification), for: .touchUpInside)
//    }
//
//    // MARK: - Step 1: Register Categories & Request Authorization
//    @objc private func registerCategoriesAndPermission() {
//        // 1. Standard Button Actions
//        let acceptAction = UNNotificationAction(
//            identifier: "ACTION_ACCEPT",
//            title: "Accept Invite",
//            options: [.foreground] // Launches the app when tapped
//        )
//        
//        let declineAction = UNNotificationAction(
//            identifier: "ACTION_DECLINE",
//            title: "Decline",
//            options: [.destructive] // Displays in red styling
//        )
//
//        // Category 1: Standard Button Actions
//        let inviteCategory = UNNotificationCategory(
//            identifier: "INVITE_CATEGORY",
//            actions: [acceptAction, declineAction],
//            intentIdentifiers: [],
//            options: .customDismissAction
//        )
//
//        // 2. Text Input Reply Action
//        let replyAction = UNTextInputNotificationAction(
//            identifier: "ACTION_REPLY",
//            title: "Quick Reply",
//            options: [],
//            textInputButtonTitle: "Send",
//            textInputPlaceholder: "Type your comment here..."
//        )
//
//        // Category 2: Text Input Action
//        let commentCategory = UNNotificationCategory(
//            identifier: "COMMENT_CATEGORY",
//            actions: [replyAction],
//            intentIdentifiers: [],
//            options: []
//        )
//
//        // 3. Register categories with system
//        let center = UNUserNotificationCenter.current()
//        center.setNotificationCategories([inviteCategory, commentCategory])
//
//        // 4. Request notification authorization
//        center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
//            DispatchQueue.main.async {
//                if granted {
//                    self?.statusLabel.text = "Categories registered & permission granted! ✅"
//                } else {
//                    self?.statusLabel.text = "Permission denied ❌"
//                }
//            }
//        }
//    }
//
//    // MARK: - Step 2: Schedule Notification with Button Actions
//    @objc private func scheduleActionButtonNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "📅 Meeting Invitation"
//        content.body = "Alex invited you to join 'iOS Architecture Sync'."
//        content.sound = .default
//        
//        // Match the categoryIdentifier registered in Step 1
//        content.categoryIdentifier = "INVITE_CATEGORY"
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: "invite_request", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { [weak self] error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    self?.statusLabel.text = "Error: \(error.localizedDescription)"
//                } else {
//                    self?.statusLabel.text = "Invite scheduled for 5s. Lock screen or hold banner to test!"
//                }
//            }
//        }
//    }
//
//    // MARK: - Step 3: Schedule Notification with Text Input Action
//    @objc private func scheduleTextInputNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "💬 New Comment"
//        content.body = "Sarah commented on your post: 'Looks great!'"
//        content.sound = .default
//        
//        // Match the text-reply categoryIdentifier
//        content.categoryIdentifier = "COMMENT_CATEGORY"
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: "comment_request", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { [weak self] error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    self?.statusLabel.text = "Error: \(error.localizedDescription)"
//                } else {
//                    self?.statusLabel.text = "Reply notification scheduled for 5s!"
//                }
//            }
//        }
//    }
//
//    // MARK: - UNUserNotificationCenterDelegate Methods
//
//    // Show banners even when the app is actively in the FOREGROUND
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.banner, .sound])
//    }
//
//    // Handle button action taps & text responses
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        
//        let actionID = response.actionIdentifier
//        
//        DispatchQueue.main.async { [weak self] in
//            switch actionID {
//            case "ACTION_ACCEPT":
//                self?.statusLabel.text = "Result: User accepted the invite! 🎉"
//
//            case "ACTION_DECLINE":
//                self?.statusLabel.text = "Result: User declined the invite. ❌"
//
//            case "ACTION_REPLY":
//                // Retrieve text typed into the notification banner
//                if let textResponse = response as? UNTextInputNotificationResponse {
//                    let userText = textResponse.userText
//                    self?.statusLabel.text = "Replied: \"\(userText)\""
//                }
//
//            case UNNotificationDismissActionIdentifier:
//                self?.statusLabel.text = "Result: Notification dismissed."
//
//            case UNNotificationDefaultActionIdentifier:
//                self?.statusLabel.text = "Result: User tapped the main banner."
//
//            default:
//                break
//            }
//        }
//
//        // Always complete the operation handler
//        completionHandler()
//    }
//}
