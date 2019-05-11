//
//  UnnaturalScrollViewController.swift
//  Hackathon
//
//  Created by Zev Eisenberg on 5/11/19.
//  Copyright © 2019 Zev Eisenberg. All rights reserved.
//

import Anchorage
import Swiftilities
import UIKit
import WebKit

final class UnnaturalScrollViewController: UIViewController {

    let webView = WKWebView(frame: .zero)
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        // View Hierarchy
        view.addSubview(webView)
        view.addSubview(scrollView)

        // Layout
        webView.edgeAnchors == view.edgeAnchors
        scrollView.edgeAnchors == view.edgeAnchors

        // Setup
        scrollView.delegate = self
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

    // via https://stackoverflow.com/a/45674575/255489
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { [weak self] (height, heightError) in
            if let height = height as? CGFloat {
                self?.webViewHeightChanged(to: height)
            }
            else {
                print("Error getting web view height: \(heightError?.localizedDescription ?? "unknown height error")")
            }
        })
    }

}

extension UnnaturalScrollViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let range = 0...(webView.scrollView.contentSize.height - webView.frame.height)
        let newOffset = scrollView.contentOffset.y.scaled(from: range, to:  range, reversed: true)
//        print(newOffset)
        webView.scrollView.contentOffset.y = newOffset
    }

}

private extension UnnaturalScrollViewController {

    enum Constants {
        static let recognizablePartOfURL = "how-to-change-scrolling-direction-on-mac-2260835"
        static let url = URL(string: "https://www.lifewire.com/\(recognizablePartOfURL)")!
    }

    func webViewHeightChanged(to newHeight: CGFloat) {
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: newHeight)
        scrollView.contentOffset.y = newHeight - scrollView.bounds.height
    }

}
