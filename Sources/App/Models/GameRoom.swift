//
//  File.swift
//  
//
//  Created by Юлия Новикова on 21.04.2024.
//

import Foundation

import Vapor
import Fluent

// Модель игровой комнаты
final class GameRoom: Model, Content {
    static let schema = "game_rooms"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "room_id")
    var roomId: String
    
    @Field(key: "invite_code")
    var inviteCode: String
    
    @Field(key: "status")
    var status: String
    
    @Field(key: "board")
    var board: [[String]] // Изменено на [[String]]
    
    @Field(key: "player_tiles")
    var playerTiles: [String]
    
    @Field(key: "leaderboard")
    var leaderboard: [String: Int]
    
    @Field(key: "tiles_in_bag")
    var tilesInBag: [String]
    
    init() { }
    
    init(id: UUID? = nil, roomId: String, inviteCode: String, status: String, board: [[String]], playerTiles: [String], leaderboard: [String: Int], tilesInBag: [String]) {
        self.id = id
        self.roomId = roomId
        self.inviteCode = inviteCode
        self.status = status
        self.board = board
        self.playerTiles = playerTiles
        self.leaderboard = leaderboard
        self.tilesInBag = tilesInBag
    }
    
    func updateData(board: [[String]]? = nil, playerTiles: [String]? = nil, leaderboard: [String: Int]? = nil, tilesInBag: [String]? = nil) {
        if let board = board {
            self.board = board
        }
        if let playerTiles = playerTiles {
            self.playerTiles = playerTiles
        }
        if let leaderboard = leaderboard {
            self.leaderboard = leaderboard
        }
        if let tilesInBag = tilesInBag {
            self.tilesInBag = tilesInBag
        }
    }
}

