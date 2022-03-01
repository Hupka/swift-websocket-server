
import Vapor

public func configure(_ app: Application) throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    let websocketManager = WebsocketManager(eventLoop: app.eventLoopGroup.next())

    app.webSocket("channel") { _, ws in
        websocketManager.connect(ws)
    }
}
