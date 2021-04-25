//
//  AuthViewController.swift
//  Branchify
//
//  Created by Alexis Rojas-Westall on 4/22/21.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
//    override var view: WKWebView!
    
    public var completionHandler: ((Bool) -> Void)?
    
    private let webView: WKWebView! = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        
        return webView
    }()
    
//    deinit{
//       view = UIView()
//        webView.navigationDelegate = nil
//    }
    
    
    
//    override func loadView() {
//       let webConfiguration = WKWebViewConfiguration()
//       let webView = WKWebView(frame: .zero, configuration: webConfiguration)
////
//////       webView.uiDelegate = self
////       view = webView
////        super.loadView()
//    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        
        webView.navigationDelegate = self
        view.addSubview(webView)


        guard let url = AuthManager.shared.signInURL  else {
            print("it is failing here")
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView,  didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
//            print("IT IS FAILING HERE")
            return
        }
        //exchange the code for an accesstoken
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value else {
            print("IT IS FAILING HERE")
            return
        }
        webView.isHidden = true
        print("woohoo")
        print("Code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
                self?.completionHandler?(success)
            }
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
