//
//  ViewController.swift
//  local_notification
//
//  Created by Hammad Ali on 03/08/2026.
//
import UIKit
import UserNotifications

class ViewController: UIViewController {

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Local Notification Demo"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let permissionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("1. Request Permission", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    private let scheduleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("2. Remind Me in 5 Seconds", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("3. Cancel Pending Reminders", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupActions()
    }

    // MARK: - Layout Setup
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [statusLabel, permissionButton, scheduleButton, cancelButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            permissionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Actions Setup
    private func setupActions() {
        permissionButton.addTarget(self, action: #selector(requestPermission), for: .touchUpInside)
        scheduleButton.addTarget(self, action: #selector(scheduleNotification), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelNotifications), for: .touchUpInside)
    }

    // MARK: - Notification Methods

    @objc private func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            DispatchQueue.main.async {
                if granted {
                    self?.statusLabel.text = "Permission Granted! ✅"
                } else {
                    self?.statusLabel.text = "Permission Denied ❌"
                }
            }
        }
    }

    @objc private func scheduleNotification() {
        // 1. Content
        let content = UNMutableNotificationContent()
        content.title = "💧 Time to Drink Water!"
        content.body = "Stay hydrated. Take a sip of water now."
        content.sound = .default
        content.badge = 1
        content.userInfo = ["type": "water_reminder"]

        // 2. Trigger (5 seconds interval)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // 3. Request
        let request = UNNotificationRequest(
            identifier: "water_reminder_id",
            content: content,
            trigger: trigger
        )

        // 4. Add to Notification Center
        UNUserNotificationCenter.current().add(request) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.statusLabel.text = "Error: \(error.localizedDescription)"
                } else {
                    self?.statusLabel.text = "Notification set for 5s! ⏱️"
                }
            }
        }
    }

    @objc private func cancelNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["water_reminder_id"])
        statusLabel.text = "Pending reminder canceled 🚫"
    }
}
