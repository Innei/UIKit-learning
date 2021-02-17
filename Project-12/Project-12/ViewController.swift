//
//  ViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/16.
//

import SwiftUI
import UIKit

var hv = UIHostingController(rootView: HomeView())
var myNavigationController = UINavigationController(rootViewController: hv)

struct TestView: View {
    var body: some View {
        Form {
            NavigationLink("Navigation", destination: EmptyView())
        }.navigationTitle("Test")
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(myNavigationController.view)
        myNavigationController.navigationBar.prefersLargeTitles = true

        myNavigationController.addChild(hv)

//        hv.view.translatesAutoresizingMaskIntoConstraints = false
//        let hvView = hv.view!
//        NSLayoutConstraint.activate([
//            hvView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            hvView.topAnchor.constraint(equalTo: view.topAnchor),
//            hvView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            hvView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            hvView.heightAnchor.constraint(equalTo: view.heightAnchor),
//            hvView.widthAnchor.constraint(equalTo: view.widthAnchor),
//        ])
    }
}
