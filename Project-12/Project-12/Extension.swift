//
//  Extension.swift
//  Project-12
//
//  Created by Innei on 2021/2/21.
//

import SwiftUI

extension Array {
    mutating func push(_ el: Element) {
        append(el)
    }

    func at(_ index: Int) -> Element? {
        let n = count
        if index < 0 {
            let u = n - abs(index % n)
            return self[u]
        } else {
            return index >= count ? nil : self[index]
        }
    }

    subscript(safelyAccess index: Index) -> Element? { indices.contains(index) ? self[index] : nil }
}

extension View {
    var rootController: UIViewController {
        UIApplication.shared.windows.first!.rootViewController!
    }
}

extension UIView {
    func addBlurToView() {
        let blurEffect = UIBlurEffect(style: .extraLight)

        let effectView = UIVisualEffectView()
        effectView.frame = bounds
        effectView.alpha = 0.99
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(effectView)

        UIView.animate(withDuration: 1) {
            effectView.effect = blurEffect
        }
    }

    func removeBlurView() {
        for view in subviews {
            if view is UIVisualEffectView {
                UIView.animate(withDuration: 0.3) {
                    (view).alpha = 0
                } completion: { _ in
                    view.removeFromSuperview()
                }
            }
        }
    }
}

extension String {
    func repeatStr(_ count: Int) -> Self {
        var value = self
        for _ in 0 ..< count {
            value.append(value)
        }
        return value
    }
}
