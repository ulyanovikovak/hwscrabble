//
//  User.swift
//
//  Created by Юлия Новикова on 21.04.2024.
//

import Vapor
import Fluent
import JWT

final class User: Model, Content {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String

    init() { }

    init(id: UUID? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}

extension User: JWTSubject {
    // Реализация требуемого свойства, возвращающего идентификатор пользователя
    var jwtSubject: String {
        return self.id!.uuidString
    }
}
