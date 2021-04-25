//
//  AuthResponse.swift
//  Branchify
//
//  Created by Alexis Rojas-Westall on 4/24/21.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String
    let scope: String
    let token_type: String
}
