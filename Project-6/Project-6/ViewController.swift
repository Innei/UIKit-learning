//
//  ViewController.swift
//  Project-6
//
//  Created by Innei on 2021/2/1.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    private var urlString: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
//        tabBarController?.hidesBottomBarWhenPushed = true

        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.refreshControl = rc

        if navigationController?.tabBarItem.tag == 0 {
            navigationItem.title = "List-0"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            navigationItem.title = "List-1"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        loadData()
    }

    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    @objc func loadData() {
        DispatchQueue.main.async {
            let urlString = self.urlString!

            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    guard self.parse(json: data) != nil else {
                        self.showError()
                        return
                    }
                } else {
                    self.showError()
                }
            }
            self.tableView.refreshControl?.endRefreshing()
        }
    }

//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scroll")
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)

//        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
//            vc.detailItem = petitions[indexPath.row]
////            vc.navigationController?.tabBarController?.tabBar.isHidden = true
////            vc.tabBarController?.tabBar.isHidden = true
//            vc.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
}
