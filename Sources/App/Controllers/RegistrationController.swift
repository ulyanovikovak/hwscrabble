//
//  File.swift
//  
//
//  Created by Юлия Новикова on 21.04.2024.
//

import Foundation
import Vapor

// Контроллер регистрации пользователей
final class RegistrationController {
    func register(_ req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map { user }
    }
}
