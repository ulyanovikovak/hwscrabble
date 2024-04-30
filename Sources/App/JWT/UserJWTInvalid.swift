//
//  UserJWTInvalid.swift
//
//
//  Created by Irlan Abushakhmanov on 30.04.2024.
//

import Foundation

enum UserJWTInvalid: Error {
    case noAccess

    var errorMessage: String {
        switch self {
            case .noAccess: return "No access with you role"
        }
    }
}
