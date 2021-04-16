//
//  SpotifyAPICaller.swift
//  Branchify
//
//  Created by Alexis Rojas-Westall on 4/10/21.
//

import UIKit
import BDBOAuth1Manager

class SpotifyAPICaller: BDBOAuth1SessionManager {
    static var baseURL = "https://api.spotify.com"

    static let client = SpotifyAPICaller(baseURL: URL(string: baseURL), consumerKey: "8928f5c47fda48048c5238c94ab09650", consumerSecret: "f9aaeabe68f14dc4a0651d3237eccc58")
//    static let getUserEndpoint = "/users/"
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    
func handleOpenUrl(url: URL){
    let requestToken = BDBOAuth1Credential(queryString: url.query)
    SpotifyAPICaller.client?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
        self.loginSuccess?()
    }, failure: { (error: Error!) in
        self.loginFailure?(error)
    })
}
    
func login(id: String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
    let _requestURL = SpotifyAPICaller.baseURL + "/users/" + id
    loginSuccess = success
    loginFailure = failure
    SpotifyAPICaller.client?.deauthorize()
    SpotifyAPICaller.client?.fetchRequestToken(withPath: SpotifyAPICaller.baseURL, method: "GET", callbackURL: URL(string: "alamoSpotify://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
        let url = URL(string: "https://api.spotify.com/oauth/authorize?oauth_token=\(requestToken.token!)")!
        UIApplication.shared.open(url)
    }, failure: { (error: Error!) -> Void in
        print("Error: \(error.localizedDescription)")
        self.loginFailure?(error)
    })
}
    
func logout (){
    deauthorize()
}
    

}
