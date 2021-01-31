//
//  ViewController.swift
//  Project-3
//
//  Created by Innei on 2021/1/31.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let mv = storyboard?.instantiateViewController(withIdentifier: "MView") as! MViewController
        navigationController?.pushViewController(mv, animated: true)
    }
}

class MTabBarContoller: UITabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        return
    }

    override func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {
        print(items)
    }
}

class MWKView: WKWebView, UIScrollViewDelegate {
    var navigationController: UINavigationController!
    func set(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    private var lastContentOffset: CGFloat = 0

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.y {
            // move up
            if navigationController?.isNavigationBarHidden == true {
                navigationController?.setNavigationBarHidden(false, animated: true)
            }
        } else if lastContentOffset < scrollView.contentOffset.y {
            // move down
            if navigationController?.isNavigationBarHidden == false {
                navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }

        // update the new position acquired
        lastContentOffset = scrollView.contentOffset.y
    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        navigationController?.isNavigationBarHidden = true
//        navigationController?.isToolbarHidden = true
//    }
//
//    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
//        navigationController?.isNavigationBarHidden = false
//        navigationController?.isToolbarHidden = false
//    }
}

class MViewController: UIViewController, WKNavigationDelegate, UIScrollViewDelegate {
    var webView: MWKView!
    var progressView: UIProgressView!

    override func loadView() {
        webView = MWKView()
        webView.set(navigationController!)
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)

        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false

        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "troph-community-git-dev-featnotification-action.troph.vercel.app", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
