import Vapor

open class WebsocketClient {
  open var id: UUID
  open var socket: WebSocket

  public init(id: UUID, socket: WebSocket) {
    self.id = id
    self.socket = socket
  }
}
