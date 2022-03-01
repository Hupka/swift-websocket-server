import App
import Cocoa
import Vapor

// Handle CTRL+C event to terminate the app
signal(SIGINT, SIG_IGN)
let sigint = DispatchSource.makeSignalSource(signal: SIGINT, queue: DispatchQueue.main)
sigint.setEventHandler {
  NSApp.terminate(nil)
}

sigint.resume()

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try configure(app)
try app.run()
