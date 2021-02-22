//
//  DrawShapeViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/21.
//

import UIKit

enum DrawType: Int, CaseIterable {
    case rect = 0
    case circle = 1
    case checkboard = 2
    case imageAndText = 3
}

extension DrawType {
    static func + (left: Self, right: Int) -> Self {
        let after = left.rawValue + right

        return after > 0 && after < Self.allCases.count ? Self.allCases[after] : .rect
    }

    static func += (left: inout Self, right: Int) {
        left = left + right
    }
}

class MainView: UIView {
    private var currentDrawType: DrawType = .rect {
        didSet {
            if currentDrawType == .checkboard || currentDrawType == .imageAndText {
                imageView.backgroundColor = .white
            } else {
                imageView.backgroundColor = .gray
            }
        }
    }

    var imageView: UIImageView!

    fileprivate let flexBox = UIView()
    override init(frame: CGRect) {
        super.init(frame: .zero)

        imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        backgroundColor = .systemBackground
        addSubview(flexBox)
        let button = UIButton(type: .system)
        button.setTitle("Redraw!", for: .normal)
        button.addTarget(self, action: #selector(redrawTapped), for: .touchUpInside)
        flexBox.flex.direction(.column).define { flex in
            flex.addItem(button)
            flex.addItem(imageView)
        }

        drawRectangle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func redrawTapped() {
        currentDrawType += 1

        switch currentDrawType {
        case .rect:
            drawRectangle()
        case .circle:
            drawCircle()
        case .checkboard:
            drawCheckerboard()
        case .imageAndText:
            drawImagesAndText()
        }
    }

    let limit = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    func drawImagesAndText() {
        // 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { _ in
            // 2
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

            // 5
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)

            // 5
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }

        // 6
        imageView.image = img
    }

    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: .init(width: limit, height: limit))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: limit, height: limit).insetBy(dx: 5, dy: 5)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = img
    }

    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: limit, height: limit))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: limit, height: limit).insetBy(dx: 5, dy: 5)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }

    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)

            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }

        imageView.image = img
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        flexBox.pin.top().horizontally().margin(pin.safeArea)

        // Then let the flexbox container layout itself
        flexBox.flex.layout(mode: .adjustHeight)
    }
}

class DrawShapeViewController: UIViewController, UIGestureRecognizerDelegate {
//    override func viewDidAppear(_ animated: Bool) {
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = MainView()

//        navigationItem.searchController = UISearchController()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(back))
//        let icon = UIImage(systemName: "arrow.backward")?.cgImage
        let attrText = NSMutableAttributedString(string: "B!!!<-")
        attrText.addAttribute(.font, value: UIFont.systemFont(ofSize: 30), range: NSRange(0 ..< attrText.length))
        let label3 = UILabel()

        label3.attributedText = attrText

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label3)
    }

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}
