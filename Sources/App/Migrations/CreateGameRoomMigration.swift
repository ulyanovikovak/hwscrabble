//
//  CreateGameRoom.swift
//
//  Created by Юлия Новикова on 21.04.2024.
//

import Vapor
import Fluent

struct CreateGameRoom: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(GameRoom.schema)
            .id()
            .field("room_id", .string, .required)
            .field("invite_code", .string, .required)
            .field("status", .string, .required)
            .field("board", .json, .required)
            .field("player_tiles", .array(of: .string), .required)
            .field("leaderboard", .json, .required)
            .field("tiles_in_bag", .array(of: .string), .required) 
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(GameRoom.schema).delete()
    }
}

