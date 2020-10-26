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
        socket.onEvent = { [weak self] event in self?.handleRegistration(event: event) }
    }
    
    private func handleRegistration(event: WebSocketEvent) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            guard let data = string.data(using: .utf8),
                  let registration = try? JSONDecoder().decode(Registration.self, from: data) else { return }
            view?.showRegistrationMessage(registration: registration)
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        default:
            break
        }
    }
    
    func sendUserRegistration(registration: Registration, nickName: String) {
        let user = User(ID: registration.userID, nickName: "ASV44")
        guard let userData = try? JSONEncoder().encode(user) else { return }
        socket.write(data: userData)
        socket.onEvent = { [weak self] event in self?.handleMessages(event: event) }
    }
    
    private func handleMessages(event: WebSocketEvent) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        default:
            break
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
