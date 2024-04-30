//
//  UserJWTVerification.swift
//
//
//  Created by Irlan Abushakhmanov on 30.04.2024.
//

import Vapor
import JWT

extension UserJWT: JWTPayload {
    public func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }

    public func verifyDate() throws {
        try self.expiration.verifyNotExpired()
    }
}
