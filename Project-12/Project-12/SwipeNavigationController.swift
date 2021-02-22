//
//  SwipeNavigationController.swift
//  Project-12
//
//  Created by Innei on 2021/2/21.
//

import UIKit
/// Make pop gesture full screen triggered.
final class SwipeNavigationController: UINavigationController {
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.isEnabled = false
        let popGesture = UIPanGestureRecognizer()
        popGesture.delegate = self
        popGesture.maximumNumberOfTouches = 1
        view.addGestureRecognizer(popGesture)

        let handleTransition = NSSelectorFromString("handleNavigationTransition:")

        popGesture.addTarget(interactivePopGestureRecognizer!.delegate!, action: handleTransition)
    }

    // MARK: - Overrides

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true

        super.pushViewController(viewController, animated: animated)
    }

    // MARK: - Private Properties

    fileprivate var duringPushAnimation = false
}

// MARK: - UINavigationControllerDelegate

extension SwipeNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? SwipeNavigationController else { return }

        swipeNavigationController.duringPushAnimation = false
    }
}

// MARK: - UIGestureRecognizerDelegate

extension SwipeNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }

        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return viewControllers.count > 1 && duringPushAnimation == false
    }
}
