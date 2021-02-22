//
//  FlexLayoutViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/20.
//
import FlexLayout
import PinLayout
import UIKit

fileprivate let rootFlexContainer = UIView()
class IntroView: UIView {
    fileprivate let rootFlexContainer = UIView()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        let imageView = UIImageView(image: UIImage(named: "flexlayout-logo"))

        let segmentedControl = UISegmentedControl(items: ["Intro", "FlexLayout", "PinLayout"])
        segmentedControl.selectedSegmentIndex = 0

        let label = UILabel()
        label.text = "Flexbox layouting is simple, powerfull and fast.\n\nFlexLayout syntax is concise and chainable."
        label.numberOfLines = 0

        let bottomLabel = UILabel()
        bottomLabel.text = "FlexLayout/yoga is incredibly fast, its even faster than manual layout."
        bottomLabel.numberOfLines = 0

        rootFlexContainer.flex.direction(.column).padding(12).define { flex in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(imageView).width(100).aspectRatio(of: imageView)

                flex.addItem().direction(.column).paddingLeft(12).grow(1).shrink(1).define { flex in
                    flex.addItem(segmentedControl).marginBottom(12).grow(1)
                    flex.addItem(label)
                }
            }

            flex.addItem().height(1).marginTop(12).backgroundColor(.lightGray)
            flex.addItem(bottomLabel).marginTop(12)
        }

        addSubview(rootFlexContainer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)

        // Then let the flexbox container layout itself
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}

class FlexLayoutViewController: UIViewController {
    fileprivate var mainView: IntroView {
        return view as! IntroView
    }

    override func loadView() {
        view = IntroView()
    }

}
