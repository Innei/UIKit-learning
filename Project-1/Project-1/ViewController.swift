//
//  ViewController.swift
//  Project-1
//
//  Created by Innei on 2021/1/29.
//

import UIKit

class ViewController: UITableViewController {
    private var pictures: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.refreshControl = refreshControl

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!

        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
//            print(item)
        }
    }

    @objc func handleRefresh() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as! TableCellView
        cell.accessoryType = .disclosureIndicator
        cell.imageView2?.image = UIImage(named: pictures[indexPath.row])
        cell.imageView2?.contentMode = .scaleAspectFit
        cell.imageView2?.clipsToBounds = true
        cell.imageView2?.layer.cornerRadius = 100
        cell.titleLabel.text = pictures[indexPath.row]
        cell.descLabel.text = "\(indexPath.row)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[index]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
