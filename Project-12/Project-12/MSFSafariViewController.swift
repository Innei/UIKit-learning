//
//  MSFSafariViewController.swift
//  Project-12
//
//  Created by Innei on 2021/2/23.
//

import SafariServices
import UIKit

class Project {
    public var projects = [[String]]()
    init() {
        projects.append(["Project 1: Storm Viewer", "Constants and variables, UITableView, UIImageView, FileManager, storyboards"])
        projects.append(["Project 2: Guess the Flag", "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+= and -=), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController"])
        projects.append(["Project 3: Social Media", "UIBarButtonItem, UIActivityViewController, the Social framework, URL"])
        projects.append(["Project 4: Easy Browser", "loadView(), WKWebView, delegation, classes and structs, URLRequest, UIToolbar, UIProgressView., key-value observing"])
        projects.append(["Project 5: Word Scramble", "Closures, method return values, booleans, NSRange"])
        projects.append(["Project 6: Auto Layout", "Get to grips with Auto Layout using practical examples and code"])
        projects.append(["Project 7: Whitehouse Petitions", "JSON, Data, UITabBarController"])
    }
}

class MSFSafariViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, SFSafariViewControllerDelegate, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in

            self.makeContextMenu()
        })
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            searchedText = nil
            tableView.reloadData()
            return
        }
        searchedText = text
        tableView.reloadData()
    }

    var project = Project()
    var searchedText: String?

    var projects: [[String]] {
        if let searchedText = searchedText, searchedText.count > 0 {
            return project.projects.filter { $0.joined(separator: "\n").contains(searchedText) }
        } else {
            return project.projects
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .systemBackground
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler))
        tableView.addGestureRecognizer(longPressGesture)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

//        let searchResController = UIViewController()
//        let innerView = UIView()
//        searchResController.view = innerView
//        innerView.backgroundColor = .systemBlue
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = searchController

        title = "SFSafariView"
    }

    @objc func longPressHandler(longPressGesture: UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: p)
        if indexPath == nil {
            print("Long press on table view, not row.")
        } else if longPressGesture.state == UIGestureRecognizer.State.began {
            print("Long press on row, at \(indexPath!.row)")
            let interaction = UIContextMenuInteraction(delegate: self)

            tableView.cellForRow(at: indexPath!)?.addInteraction(interaction)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let project = projects[indexPath.row]
        cell.textLabel?.attributedText = makeAttributedString(title: project[0], subtitle: project[1])
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .left
        return cell
    }

    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]

        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)

        titleString.append(subtitleString)

        return titleString
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTutorial(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func makeContextMenu() -> UIMenu {
        let share = UIAction(title: "Share Pupper", image: UIImage(systemName: "square.and.arrow.up")) { _ in
        }

        // Create and return a UIMenu with the share action
        return UIMenu(title: "Main Menu", children: [share])
    }

    func showTutorial(_ which: Int) {
        if let url = URL(string: "https://innei.ren/") {
            let config = SFSafariViewController.Configuration()
//            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            vc.delegate = self
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true)
        }
    }
}
