//
//  APIKeys.swift
//  Addison Clifton

import Foundation

enum APIKeys {
    case id, fullName, email, password, data, message, token, profileImage
    
    var key: String {
        switch self {
        case .id: return "id"
        case .fullName: return "full_name"
        case .email: return "email"
        case .password: return "password"
        case .data: return "data"
        case .message: return "message"
        case .token: return "token"
        case .profileImage: return "profile_image"
        }
    }
}
