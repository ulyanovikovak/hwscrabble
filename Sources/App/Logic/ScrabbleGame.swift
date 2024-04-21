//
//  File.swift
//  
//
//  Created by Юлия Новикова on 21.04.2024.
//

import Foundation

// Логика игры Scrabble
struct ScrabbleGame {
    static let letterValues: [Character: Int] = [
        "A": 1, "B": 3, "C": 3, "D": 2, "E": 1,
        "F": 4, "G": 2, "H": 4, "I": 1, "J": 8,
        "K": 5, "L": 1, "M": 3, "N": 1, "O": 1,
        "P": 3, "Q": 10, "R": 1, "S": 1, "T": 1,
        "U": 1, "V": 4, "W": 4, "X": 8, "Y": 4, "Z": 10
    ]
    
    // Метод для размещения слова на игровой доске
    static func placeWord(_ word: String, at position: (x: Int, y: Int), on board: inout [[Character]]) -> Bool {
        let wordArray = Array(word.uppercased())
        let wordLength = wordArray.count
        
        // Проверка, что слово полностью помещается на доску
        if position.x + wordLength > board.count || position.y + wordLength > board[0].count {
            return false
        }
        
        // Проверка, что слово не перекрывает уже существующие буквы на доске
        for (index, letter) in wordArray.enumerated() {
            let x = position.x + index
            let y = position.y
            if board[x][y] != " " && board[x][y] != letter {
                return false
            }
        }
        
        // Добавление слова на доску
        for (index, letter) in wordArray.enumerated() {
            let x = position.x + index
            let y = position.y
            board[x][y] = letter
        }
        
        return true
    }
}
