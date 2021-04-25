//
//  AuthManager.swift
//  Branchify
//
//  Created by Alexis Rojas-Westall on 4/22/21.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    struct Constants {
        static let clientID = "8928f5c47fda48048c5238c94ab09650"
        static let clientSecret = "f9aaeabe68f14dc4a0651d3237eccc58"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    }
    
    
    public var signInURL: URL? {
//        let scopes = "user-read-email user-read-private user-read-playback-state user-modify-playback-state user-read-currently-playing streaming app-remote-control playlist-read-collaborative playlist-modify-public playlist-read-private playlist-modify-private user-library-modify user-library-read user-top-read user-read-playback-position user-read-recently-played user-follow-read user-follow-modify"
        let redirectURI = "http://branchify.com/callback/"
//        let redirectURI = "https://Branchify-login://"
        let scopes = "user-read-private"
        let baseURL = "https://accounts.spotify.com/authorize"
        let string =  "\(baseURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&show_dialog=TRUE&redirect_uri=\(redirectURI)"
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool? {
        return false
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void )) {
        guard let url = URL(string: Constants.tokenAPIURL) else {
            print("IT IS FAILING HERE")
            return
        }
        print("woohoo")
        var compenents = URLComponents()
        compenents.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "http://branchify.com/callback/"),
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = compenents.query?.data(using: .utf8)
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failed to get base64")
            completion(false)
            return
        }
        request.setValue("Basic\(base64String)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data,
                  error == nil else {
                completion(false)
                return
            }

            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    // get token
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        UserDefaults.standard.setValue(result.refresh_token, forKey: "refresh_token")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
}
