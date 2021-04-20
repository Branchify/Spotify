//
//  LoginViewController.swift
//  Branchify
//
//  Created by Alexis Rojas-Westall on 4/10/21.
//

import UIKit
import WebKit
import Alamofire

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    var accessToken: String!
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func onLoginButton(_ sender: Any) {
        let spotifyVC = UIViewController() // Create Spotify Auth View Controller
        let webView = WKWebView() // Create WebView
        let navController = UINavigationController(rootViewController: spotifyVC) // Create Navigation Controller
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        webView.navigationDelegate = self
        spotifyVC.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: spotifyVC.view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: spotifyVC.view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: spotifyVC.view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: spotifyVC.view.trailingAnchor)
        ])
        
        let authURL = "https://accounts.spotify.com/authorize?response_type=token&client_id=" + SpotifyConstants.CLIENT_ID + "&scope=" + SpotifyConstants.SCOPE.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&redirect_uri=" + SpotifyConstants.REDIRECT_URI + "&show_dialog=false"
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        webView.load(urlRequest)
        
        spotifyVC.navigationItem.leftBarButtonItem = cancelButton
        spotifyVC.navigationItem.rightBarButtonItem = refreshButton
        navController.navigationBar.titleTextAttributes = textAttributes
        spotifyVC.navigationItem.title = "spotify.com"
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.init(red: CGFloat(0x1D)/255, green: CGFloat(0xB9)/255, blue: CGFloat(0x54)/255, alpha: 1.0)
        navController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        navController.modalTransitionStyle = .coverVertical
        
        self.present(navController, animated: true, completion: nil)
        
    }
    
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshAction() {
        self.webView.reload()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        requestCallbackURL(request: navigationAction.request)
        decisionHandler(.allow)
    }
    
    func requestCallbackURL(request: URLRequest) {
        let requestURL = (request.url?.absoluteString)! as String
        if requestURL.hasPrefix(SpotifyConstants.REDIRECT_URI) {
            if requestURL.contains("#access_token=") {
                if let range = requestURL.range(of: "=") {
                    let spotifyAccessToken = requestURL[range.upperBound...]
                    if let range = spotifyAccessToken.range(of: "&token_type=") {
                        let spotifyAccessTokenFinal = spotifyAccessToken[..<range.lowerBound]
                        handleAuth(spotifyAccessToken: String(spotifyAccessTokenFinal))
                    }
                }
            }
        }
    }
    
    func handleAuth(spotifyAccessToken: String) {
        self.accessToken = spotifyAccessToken
        print("got access token")
        
//        // send access token to API
//        let postAPIUrl = "https://that-tune.herokuapp.com/api/new-token"
//        let payload = ["token": String(self.accessToken)]
//        AF.request(postAPIUrl, method: .post, parameters: payload, encoding: JSONEncoding.default).responseJSON { response in
//            debugPrint(response)
//
//            // UserDefaults.standard.set(response["user_id"], forKey: "user")
//        }
        
        self.dismiss(animated: true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainLoginNavigation")
        
        (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate).changeRootViewController(mainTabBarController)
    }
//        let myUrl = "https://api.spotify.com/oauth/request_token"
//
//        SpotifyAPICaller.client?.login(id: myUrl, success: {
//            UserDefaults.standard.set(true, forKey: "userLoggedIn")
//            self.performSegue(withIdentifier: "loginToHome", sender: self)
//        }, failure: { (Error) in
//            print("Could not log in!")
//        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


