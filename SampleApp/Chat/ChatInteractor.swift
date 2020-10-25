import Starscream

final class ChatInteractor: ChatViewOutput {
    private weak var view: ChatViewInput?
    private var socket: WebSocket!
    private var isConnected = false
    
    init(view: ChatViewInput) {
        self.view = view
    }
    
    func viewDidLoad() {
        establishWebsocketConnection()
    }
    
    private func establishWebsocketConnection() {
        var request = URLRequest(url: URL(string: "http://localhost:8080/websocket-connect")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.connect()
        socket.onEvent = { [weak self] event in self?.handle(event: event) }
    }
    
    private func handle(event: WebSocketEvent) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
   private func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
}
