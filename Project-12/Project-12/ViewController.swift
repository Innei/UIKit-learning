//
//  ViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/16.
//

import SwiftUI
import UIKit

var hv = UIHostingController(rootView: ListView())
var myNavigationController = UINavigationController(rootViewController: hv)

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(myNavigationController.view)
        myNavigationController.navigationBar.prefersLargeTitles = true
    }
}
