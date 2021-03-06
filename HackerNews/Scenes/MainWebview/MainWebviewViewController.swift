//
//  MainWebviewViewController.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit
import WebKit

class MainWebviewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var url: String!
    var navigationTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = navigationTitle
        
        startLoader()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.timeoutInterval = 20.0
            webView.load(request)
        } else {
            showMessage(message: Constants.Localizable.DEFAULT_ERROR_MESSAGE) { [weak self] in
                self?.endLoader()
                self?.closeWebView()
            }
        }
    }
    
    private func closeWebView() {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func showError(error: String) {
        endLoader()
        showMessage(message: error) { [weak self] in
            self?.closeWebView()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MainWebviewViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard navigationAction.targetFrame == nil, let url = navigationAction.request.url else {
            return nil
        }
        let urlString = url.absoluteString
        if urlString.lowercased().contains("http") || urlString.lowercased().contains("https") {
            webView.load(URLRequest(url: url))
        } else if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        showMessage(message: message, closure: completionHandler)
    }
}
extension MainWebviewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        endLoader()
        navigationItem.title = navigationTitle ?? webView.title
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showError(error: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showError(error: error.localizedDescription)
    }
}
