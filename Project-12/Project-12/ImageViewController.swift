//
//  ImageViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/17.
//

import UIKit

class ImageViewController: UIViewController, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in

            self.makeContextMenu()
        })
    }

    var imageView: UIImageView!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.backgroundColor = .systemBackground
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit

        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        let reconginzer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        imageView.addGestureRecognizer(reconginzer)

        let interaction = UIContextMenuInteraction(delegate: self)
        imageView.addInteraction(interaction)
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addGestureRecognizer(reconginzer)
        button.setTitle("Tap", for: .normal)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    func makeContextMenu() -> UIMenu {
        let share = UIAction(title: "Share Pupper", image: UIImage(systemName: "square.and.arrow.up")) { action in
            let ac = UIActivityViewController(activityItems: [self.imageView.image?.pngData()], applicationActivities: nil)
            self.present(ac, animated: true, completion: nil)
        }

        // Create and return a UIMenu with the share action
        return UIMenu(title: "Main Menu", children: [share])
    }

    @objc func tapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
                           animations: {
                               switch self.currentAnimation {
                               case 0:
                                   self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                               case 1:
                                   self.imageView.transform = .identity
                               case 2:
                                   self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)

                               case 3:
                                   self.imageView.transform = .identity
                               case 4:
                                   self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                               case 5:
                                   self.imageView.transform = .identity
                               case 6:
                                   self.imageView.alpha = 0.1
                                   self.imageView.backgroundColor = UIColor.green

                               case 7:
                                   self.imageView.alpha = 1
                                   self.imageView.backgroundColor = UIColor.clear
                               default:
                                   break
                               }
                           }) { _ in
            }

            currentAnimation += 1

            if currentAnimation > 7 {
                currentAnimation = 0
            }
        }
    }
}
