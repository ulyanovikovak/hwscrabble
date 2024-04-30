//
//  RegistrationController.swift
//
//  Created by Юлия Новикова on 21.04.2024.
//

import Vapor
import Fluent
import JWT

// Контроллер регистрации пользователей
final class RegistrationController {
    func register(_ req: Request) throws -> EventLoopFuture<UserJWT> {
        let user = try req.content.decode(User.self)
        
        // Проверяем, существует ли пользователь с таким же логином
        return User.query(on: req.db)
            .filter(\User.$username == user.username)
            .first()
            .flatMap { existingUser -> EventLoopFuture<UserJWT> in
                if let existingUser {
                    // Если пользователь уже существует, возвращаем ошибку
                    return req.eventLoop.makeFailedFuture(
                        Abort(
                            .badRequest,
                            reason: "User with username '\(user.username)' already exists"
                        )
                    )
                } else {
                    return user.save(on: req.db).map {
                        let payload = UserJWT(
                            expiration: ExpirationClaim.oneDay(),
                            userId: user.id!
                        )
                        return payload
                    }
                }
        }
    }
}
