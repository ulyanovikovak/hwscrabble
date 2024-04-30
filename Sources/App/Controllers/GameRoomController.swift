//
//  GameRoomController.swift
//
//  Created by Юлия Новикова
//

import Vapor
import Fluent

// Контроллер игровых комнат
final class GameRoomController {
    // Метод для создания новой игровой комнаты
        func createRoom(_ req: Request) throws -> EventLoopFuture<GameRoom> {
            let room = try req.content.decode(GameRoom.self)
            
            // Проверяем, существует ли комната с таким же идентификатором
            return GameRoom.query(on: req.db)
                .filter(\GameRoom.$roomId == room.roomId)
                .first()
                .flatMap { existingRoom -> EventLoopFuture<GameRoom> in
                    if let existingRoom {
                        // Если комната уже существует, возвращаем ошибку
                        return req.eventLoop.makeFailedFuture(Abort(.badRequest, reason: "Room with ID '\(room.roomId)' already exists"))
                    } else {
                        // Если комнаты с таким идентификатором не существует, сохраняем новую комнату
                        room.status = "open"
                        return room.save(on: req.db).map { room }
                    }
                }
        }
    
    // Метод для присоединения к существующей игровой комнате
    func joinRoom(_ req: Request) throws -> EventLoopFuture<GameRoom> {
        let roomIdString = try req.parameters.require("roomId")
        guard let roomId = UUID(uuidString: roomIdString) else {
            throw Abort(.badRequest)
        }
        return GameRoom.find(roomId, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { room in
                room.status = "open"
                return room.update(on: req.db).map { room }
            }
    }
    
    // Метод для проверки статуса игровой комнаты
    func checkRoomStatus(_ req: Request) throws -> EventLoopFuture<GameRoom> {
        let roomIdString = try req.parameters.require("roomId")
        guard let roomId = UUID(uuidString: roomIdString) else {
            throw Abort(.badRequest)
        }
        return GameRoom.find(roomId, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // Метод для обновления данных игровой комнаты
    func updateRoom(_ req: Request) throws -> EventLoopFuture<GameRoom> {
        let updatedRoom = try req.content.decode(GameRoom.self)
        return updatedRoom.update(on: req.db).map { updatedRoom }
    }
    
    // Метод для добавления участника в комнату
    func addPlayer(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let roomIdString = try req.parameters.require("roomId")
        guard let roomId = UUID(uuidString: roomIdString) else {
            throw Abort(.badRequest)
        }
        let playerId = try req.parameters.require("playerId")
        return GameRoom.find(roomId, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { room in
                room.playerTiles.append(playerId)
                return room.save(on: req.db).transform(to: .ok)
            }
    }
    
    // Метод для удаления участника из комнаты
    func removePlayer(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let roomIdString = try req.parameters.require("roomId")
        guard let roomId = UUID(uuidString: roomIdString) else {
            throw Abort(.badRequest)
        }
        let playerId = try req.parameters.require("playerId")
        return GameRoom.find(roomId, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { room in
                if let index = room.playerTiles.firstIndex(of: playerId) {
                    room.playerTiles.remove(at: index)
                }
                return room.save(on: req.db).transform(to: .ok)
            }
    }
    
    // Метод для обновления лидерборда
    func updateLeaderboard(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let roomIdString = try req.parameters.require("roomId")
        guard let roomId = UUID(uuidString: roomIdString) else {
            throw Abort(.badRequest)
        }
        let playerId = try req.parameters.require("playerId")
        let score = try req.parameters.require("score", as: Int.self)
        return GameRoom.find(roomId, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { room in
                room.leaderboard[playerId] = score
                return room.save(on: req.db).transform(to: .ok)
            }
    }
}
