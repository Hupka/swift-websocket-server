import Vapor

open class WebsocketClients {
  var eventLoop: EventLoop
  var storage: [UUID: WebsocketClient]

  var active: [WebsocketClient] {
    storage.values.filter { !$0.socket.isClosed }
  }

  init(eventLoop: EventLoop, clients: [UUID: WebsocketClient] = [:]) {
    self.eventLoop = eventLoop
    storage = clients
  }

  func add(_ client: WebsocketClient) {
    storage[client.id] = client
  }

  func remove(_ client: WebsocketClient) {
    storage[client.id] = nil
  }

  func find(_ uuid: UUID) -> WebsocketClient? {
    storage[uuid]
  }

  deinit {
    let futures = self.storage.values.map { $0.socket.close() }
    try! self.eventLoop.flatten(futures).wait()
  }
}
