//
//  UserDetails.swift
//  GoFit
//
//  Created by Ankit Singh  on 04/09/21.
//

import UIKit

struct UserDetails: Codable {
    let id: Int
    var email: String
    var fullName: String
    var profileImageAPIURL: String
    var token: String
    
    init(data: [String: Any]) {
        id = data[APIKeys.id.key] as? Int ?? 0
        email = data[APIKeys.email.key] as? String ?? ""
        fullName = data[APIKeys.fullName.key] as? String ?? ""
        profileImageAPIURL = data[APIKeys.profileImage.key] as? String ?? ""
        token = data[APIKeys.token.key] as? String ?? ""
    }
}
