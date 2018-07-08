//
//  YNABAuthorisationViewController.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import UIKit
import WebKit

class YNABAuthorisationViewController: UIViewController {

    var webView: WKWebView!
    let clientId = ""
    let redirectUri = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://app.youneedabudget.com/oauth/authorize?client_id=\(clientId)&redirect_uri=\(redirectUri)&response_type=token"
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension YNABAuthorisationViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
        guard let url = navigationAction.request.url else {
            return
        }
        
        if url.absoluteString.contains("access_token") {
            dismiss(animated: true, completion: nil)
        }
    }
}
