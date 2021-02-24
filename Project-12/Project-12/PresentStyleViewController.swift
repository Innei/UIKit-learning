//
//  PresentStyleViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/23.
//

import SnapKit
import UIKit

class PresentStyleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
    }

    func modal(style: UIModalPresentationStyle) {
        let vc = UIViewController()

        vc.modalPresentationStyle = style
        let view = UIView()
        view.backgroundColor = .systemBackground
        vc.view = view
        present(vc, animated: true, completion: nil)
    }
}
//
//extension UIModalPresentationStyle: CaseIterable {
//   
//}
