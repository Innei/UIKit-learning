//
//  NSAttributedStringViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/20.
//

import FlexLayout
import SnapKit
import UIKit



class NSAttributedStringViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view).offset(200)
        }

        let attributedText = NSAttributedString(string: "This is NSAttributedString.\nThis is NSAttributedString\nhis is NSAttributedString.\nThis is NSAttributedString", attributes: [.paragraphStyle: NSMutableParagraphStyle()])
        label.attributedText = attributedText

        label.font = .boldSystemFont(ofSize: 20)

        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label2)
        label2.snp.makeConstraints { make in

            make.top.greaterThanOrEqualTo(label.snp.bottom)
            make.centerX.equalTo(label.snp.centerX)
        }

        let atText = NSMutableAttributedString(string: "This is NSAttributedString.This is NSAttributedString")

        atText.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 25), range: .init(location: 0, length: 4))
        atText.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 30), range: .init(location: 5, length: 2))
        atText.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: .init(location: 8, length: atText.mutableString.length - 8))

        atText.addAttribute(.backgroundColor, value: UIColor.systemGroupedBackground, range: .init(location: 0, length: atText.length))
        label2.attributedText = atText
        label2.numberOfLines = 0
        label2.preferredMaxLayoutWidth = UIScreen.main.bounds.width
        

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        // 3
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 36),
            .paragraphStyle: paragraphStyle,
        ]

        // 4
        let string = "The best-laid schemes o'\nmice an' men gang aft agley"
        let attributedString = NSAttributedString(string: string, attributes: attrs)

        let label3 = UILabel()
        view.addSubview(label3)
        label3.textAlignment = NSTextAlignment.justified
        label3.attributedText = attributedString
        label3.lineBreakMode = .byWordWrapping
        label3.numberOfLines = 0
        label3.preferredMaxLayoutWidth = UIScreen.main.bounds.width
        label3.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom)
        }

        let titleLabel = UILabel()

        navigationItem.titleView = titleLabel
        titleLabel.attributedText = atText

//        let backLabel = UILabel()
//        backLabel.attributedText = NSAttributedString(string: "Back", attributes: [.backgroundColor: UIColor.systemPink])

//        let barItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: "")
//        barItem.title = ""
//
//        navigationItem.leftBarButtonItem = barItem
    }
}
