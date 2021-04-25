//
//  WelcomeViewController.swift
//  Branchify
//
//  Created by Alexis Rojas-Westall on 4/22/21.
//

import UIKit
import WebKit

class WelcomeViewController: UIViewController, WKNavigationDelegate {
    
    private let SignInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Sign In with Spotify", for: .normal)
//        button.titleLabel?.font =  UIFont(name: bold, size: 20)
        button.setTitleColor(.white, for: .normal)
//        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
//    @IBOutlet weak var SignInButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGray2
        view.addSubview(SignInButton)
        SignInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
//    @IBAction func onSignInButton(_ sender: Any) {
////        let myUrl = "https://api.spotify.com/oauth/request_token"
////        SpotifyAPICaller.client?.login(id: myUrl, success: {
////            UserDefaults.standard.set(true, forKey: "userLoggedIn")
////            self.performSegue(withIdentifier: "loginToHome", sender: self)
////        }, failure: { (Error) in
////            print("Could not log in!!!")
////        })
//        didTapSignIn()
//    }
    override func viewDidAppear(_ animated: Bool) {
        
//        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
//            self.performSegue(withIdentifier: "loginToHome", sender: self)
//        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        SignInButton.frame = CGRect(
            x: 115,
            y: 450,
            width: 200,
            height: 50)
    }
        
    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        print("it is FAILING here")
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    @objc func didTapSignIn() {
//        let vc = AuthViewController()
//        vc.completionHandler = { [weak self] success in
//            DispatchQueue.main.async {
//                self?.handleSignIn(success: success)
//            }
//        }
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    private func handleSignIn(success: Bool) {
        // log user in or tell them error
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "something went wrong when signing in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
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
