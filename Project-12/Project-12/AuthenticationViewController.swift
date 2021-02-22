//
//  AuthenticationViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/22.
//

import LocalAuthentication
import SnapKit
import UIKit

enum AuthStatus: String {
    case pass = "通过"
    case wait = "等待"
    case failure = "失败"
}

class AuthenticationViewController: UIViewController {
    private var status: AuthStatus = .wait {
        willSet {
            if newValue == .failure {
                return
            }
            for view in view.subviews {
                if view is UILabel && view.accessibilityIdentifier == "status" {
                    let label = view as! UILabel
                    label.text = newValue.rawValue
                }
            }
        }
    }

    private var failureCount = 0 {
        didSet {
            for view in view.subviews {
                if view is UILabel && view.accessibilityIdentifier == "status" {
                    let label = view as! UILabel
                    label.text = status.rawValue + " \(failureCount) times"
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let button = UIButton(type: .system)
        button.setTitle("Authentication", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        button.addTarget(self, action: #selector(authenticateTapped), for: .touchUpInside)

        let label = UILabel()
        label.text = status.rawValue
        label.accessibilityIdentifier = "status"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(50)
            make.centerX.equalTo(view)
        }
    }

    @objc func authenticateTapped() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, _ in

                DispatchQueue.main.async {
                    if success {
                        self.status = .pass
                    } else {
                        self.status = .failure
                        self.failureCount += 1
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
