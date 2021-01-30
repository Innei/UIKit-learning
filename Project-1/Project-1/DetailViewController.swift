//
//  DetailViewController.swift
//  Project-1
//
//  Created by Innei on 2021/1/30.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    var selectedImage: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never

        
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = nil
        navigationController?.hidesBarsOnTap = false
    }
}
