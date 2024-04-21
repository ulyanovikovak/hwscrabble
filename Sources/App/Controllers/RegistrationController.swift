//
//  File.swift
//  
//
//  Created by Юлия Новикова on 21.04.2024.
//

import Foundation
import Vapor
import Fluent

// Контроллер регистрации пользователей
final class RegistrationController {
    func register(_ req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        
        // Проверяем, существует ли пользователь с таким же логином
        return User.query(on: req.db)
            .filter(\User.$username == user.username)
            .first()
            .flatMap { existingUser -> EventLoopFuture<User> in
                if let _ = existingUser {
                    // Если пользователь уже существует, возвращаем ошибку
                    return req.eventLoop.makeFailedFuture(Abort(.badRequest, reason: "User with username '\(user.username)' already exists"))
                } else {
                    // Если пользователя с таким логином не существует, сохраняем нового пользователя
                    return user.save(on: req.db).map { user }
                }
            }
    }
}






