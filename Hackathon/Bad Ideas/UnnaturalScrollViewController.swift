//
//  UnnaturalScrollViewController.swift
//  Hackathon
//
//  Created by Zev Eisenberg on 5/11/19.
//  Copyright © 2019 Zev Eisenberg. All rights reserved.
//

import Anchorage
import UIKit
import WebKit

final class UnnaturalScrollViewController: UIViewController {

    let webView = WKWebView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        // View Hierarchy
        view.addSubview(webView)

        // Layout
        webView.edgeAnchors == view.edgeAnchors

        // Setup
        webView.navigationDelegate = self
        let request = URLRequest(url: Constants.url)
        webView.load(request)
    }

}

extension UnnaturalScrollViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.absoluteString.contains(Constants.recognizablePartOfURL) ?? false {
            decisionHandler(.allow)
        }
        else {
            decisionHandler(.cancel)
        }
    }

}

private extension UnnaturalScrollViewController {

    enum Constants {
        static let recognizablePartOfURL = "how-to-change-scrolling-direction-on-mac-2260835"
        static let url = URL(string: "https://www.lifewire.com/\(recognizablePartOfURL)")!
    }

}
