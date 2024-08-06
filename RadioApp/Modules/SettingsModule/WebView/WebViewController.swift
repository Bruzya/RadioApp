//
//  WebViewController.swift
//  RadioApp
//
//  Created by Drolllted on 06.08.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var urlString: String!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    // MARK: - WKNavigationDelegate

    func webView( _ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationController?.popViewController(animated: true)
    }

    func webView( _ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(error.localizedDescription)")
    }
}
