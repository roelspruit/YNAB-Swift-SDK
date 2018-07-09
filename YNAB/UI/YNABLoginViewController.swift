//
//  YNABLoginViewController.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import UIKit
import WebKit

public class YNABLoginViewController: UIViewController {

    var webView: WKWebView!
    let clientId: String
    let redirectUri: String
    var completion: ((_ accessToken: AccessToken?) -> Void)
    
    public init(clientId: String, redirectUri: String, completion: @escaping (_ accessToken: AccessToken?) -> Void) {
        self.clientId = clientId
        self.redirectUri = redirectUri
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://app.youneedabudget.com/oauth/authorize?client_id=\(clientId)&redirect_uri=\(redirectUri)&response_type=token"
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension YNABAuthorisationViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
        guard let url = navigationAction.request.url else {
            return
        }
        
        if url.absoluteString.contains("access_token"),
            let parameterString = url.absoluteString.components(separatedBy: "#").last {
            
            let parameters = parseParameters(url: parameterString)
            
            if let expirationSeconds = Double(parameters["expires_in"]!) {
                let expiration = Date().addingTimeInterval(expirationSeconds)
                let token = AccessToken(token: parameters["access_token"]!, expirationDate: expiration)
                
                decisionHandler(.cancel)
                completion(token)
                dismiss(animated: true, completion: nil)
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    private func parseParameters(url: String) -> [String: String] {
        let components = url.components(separatedBy: "&")
        
        var dict = Dictionary<String, String>()
        components.forEach { (parameter) in
            let paramComponents = parameter.components(separatedBy: "=")
            if paramComponents.count == 2 {
                dict[paramComponents.first!] = paramComponents.last!
            }
        }
        
        return dict
    }
}


