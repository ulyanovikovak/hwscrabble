import Fluent
import Vapor


// Configure your application's routes here
public func routes(_ app: Application) throws {
    let registrationController = RegistrationController()
    let gameRoomController = GameRoomController()

    // Регистрация нового пользователя
    app.post("register", use: registrationController.register)

    // Создание новой игровой комнаты
    app.post("rooms", use: gameRoomController.createRoom)
    
    // Присоединение к существующей игровой комнате
    app.post("rooms", ":roomId", "join", use: gameRoomController.joinRoom)
    
    // Проверка статуса игровой комнаты
    app.get("rooms", ":roomId", use: gameRoomController.checkRoomStatus)
    
    // Обновление данных игровой комнаты
    app.put("rooms", use: gameRoomController.updateRoom)
    
    
    // Добавить участника в комнату
    app.post("rooms", ":roomId", "players", ":playerId", use: gameRoomController.addPlayer)
    
    // Удалить участника из комнаты
    app.delete("rooms", ":roomId", "players", ":playerId", use: gameRoomController.removePlayer)
    
    // Обновление лидерборда
    app.post("rooms", ":roomId", "leaderboard", "update", use: gameRoomController.updateLeaderboard)
}

