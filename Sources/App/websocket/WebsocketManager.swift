import Vapor

class WebsocketManager {
  var clients: WebsocketClients

  init(eventLoop: EventLoop) {
    clients = WebsocketClients(eventLoop: eventLoop)
  }

  func connect(_ ws: WebSocket) {
    ws.onBinary { [unowned self] ws, buffer in
      if let msg = buffer.decodeWebsocketMessage(Connect.self) {
        let app = WebsocketClient(id: msg.client, socket: ws)
        self.clients.add(app)
        print("Added client app: \(msg.client)")

        // for demonstration purposes immediately respond to the client
        notify()
      }
    }

    ws.onText { ws, _ in
      ws.send("pong")
    }
  }

  func notify() {
    let connectedClients = clients.active.compactMap { $0 as WebsocketClient }
    guard !connectedClients.isEmpty else {
      return
    }

    connectedClients.forEach { client in

      let person = Person(name: "Adrian", male: true, age: 33)
      let msg = WebsocketMessage<Person>(client: client.id, data: person)
      let data = try! JSONEncoder().encode(msg)

      client.socket.send([UInt8](data))
    }
  }
}
