//
//  ViewController.swift
//  Project-6
//
//  Created by Innei on 2021/2/1.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()


        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.title = "List"

        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.refreshControl = rc

        loadData()
    }

    @objc func loadData() {
        DispatchQueue.main.async {
            let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"

            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
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

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
}
