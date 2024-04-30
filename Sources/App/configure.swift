import NIOSSL
import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)

    // Configure SQLite database
    app.databases.use(.sqlite(.file("scrabble.db")), as: .sqlite)

    // Apply migrations
    app.migrations.add(CreateUser())
    app.migrations.add(CreateGameRoom())
    try app.autoMigrate().wait()
}
