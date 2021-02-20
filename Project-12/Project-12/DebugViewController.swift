//
//  DebugViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/18.
//

import UIKit
import UserNotifications

class DebugViewController: UIViewController, UNUserNotificationCenterDelegate {
    var labelView: UILabel!

    private var count = 0 {
        didSet {
            print(count)
            labelView.text = String(count)
        }
    }

    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let label = UILabel(frame: CGRect(x: 20.0, y: 90.0, width: 250.0, height: 100.0))
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 50)

        labelView = label
        label.text = String(count)
        view.addSubview(label)

        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(_dismiss), for: .touchUpInside)

        let button2 = UIButton(type: .system)
        button2.setTitle("Push Notification", for: .normal)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.addTarget(self, action: #selector(pushNotification), for: .touchUpInside)

        view.addSubview(button)
        view.addSubview(button2)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.topAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.topAnchor.constraint(equalTo: button.topAnchor, constant: 20),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        timer = Timer.scheduledTimer(timeInterval: .init(3), target: self, selector:
            #selector(timerHandler), userInfo: nil, repeats: true)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }

    @objc func timerHandler() {
        count += 1
    }

    @objc func _dismiss() {
        navigationController?.popViewController(animated: true)
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }

    @objc func scheduleLocal() {
        registerCategories()
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }

//    private var request: UNNotificationRequest?
//    var rcount = 0

    @objc func pushNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false))
//
//        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshNotifition), userInfo: nil, repeats: true)
//        timer.fire()
        center.add(request)
    }

//    @objc func refreshNotifition() {
//        request?.content
//        request
//        rcount += 1
//    }

    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo

        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")

            case "show":
                // the user tapped our "show more info…" button
                print("Show more information…")

            default:
                break
            }
        }

        // you must call the completion handler when you're done
        completionHandler()
    }
}
