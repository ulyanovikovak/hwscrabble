//
//  File.swift
//  
//
//  Created by Irlan Abushakhmanov on 30.04.2024.
//

import Foundation
import JWT

public struct UserJWT: Codable {
    public init(expiration: ExpirationClaim, userId: UUID) {
        self.expiration = expiration
        self.userId = userId
    }

    public let expiration: ExpirationClaim
    public let userId: UUID

    public enum CodingKeys: String, CodingKey {
        case expiration = "exp"
        case userId = "uid"
    }
}
