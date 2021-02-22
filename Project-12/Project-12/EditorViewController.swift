//
//  EditorViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/21.
//

import FlexLayout
import PinLayout
import UIKit

let placeholderContent = """

<!DOCTYPE html>
<html lang="en">
  <head>
    <style>
      html,
      body {
        margin: 0;
        padding: 0;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
          Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        line-height: 1.25;
        font-size: 20px;
      }
    </style>
  </head>
  <body>
    <main>
      <p
        style="
          color: cadetblue;
          font-size: xx-large;
          text-shadow: 1px 1px 1px #333;
        "
      >
        Hello, World~
      </p>
      <p style="text-align: center">Swift</p>
    </main>
  </body>
</html>


"""

class EditorView: UIView {
    fileprivate var secret: UITextView!
    init() {
        super.init(frame: .zero)

        backgroundColor = .systemBackground
        let tv = UITextView()

        secret = tv
        addSubview(tv)

        tv.font = .systemFont(ofSize: 24)
        tv.backgroundColor = .systemGroupedBackground

        let preAttrStr = try? NSMutableAttributedString(data: Data(placeholderContent.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        tv.attributedText = preAttrStr ?? NSMutableAttributedString(string: "")

        tv.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(self)
        }

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        center.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        center.addObserver(self, selector: #selector(onBlur), name: UIApplication.willResignActiveNotification, object: nil)
        center.addObserver(self, selector: #selector(onFocus), name: UIApplication.didBecomeActiveNotification, object: nil)

        
    }
   

    @objc func onFocus() {
        self.removeBlurView()
    }

 
    @objc func onBlur() {
        self.addBlurToView()
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - safeAreaInsets.bottom, right: 0)
        }

        secret.scrollIndicatorInsets = secret.contentInset

        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class EditorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view = EditorView()
        title = "Nothing to see here"
        navigationItem.largeTitleDisplayMode = .never
    }
}
