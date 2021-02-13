import Starscream

final class ChatInteractor: ChatViewOutput {
    private weak var view: ChatViewInput?
    private var socket: WebSocket!
    private let decoder: JSONDecoder = JSONDecoder()
    private let encoder: JSONEncoder = JSONEncoder()
    private var isConnected = false
    private var user: User!
    private var inputTextProcessor: ((String) -> Void)!
    private var messageHandler: ((Data) -> Void)!
    
    init(view: ChatViewInput) {
        self.view = view

        inputTextProcessor = registerUser
        messageHandler = handleRegistration
    }
    
    func viewDidLoad() {
        establishWebsocketConnection()
    }
    
    private func establishWebsocketConnection() {
        inputTextProcessor = registerUser
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
            guard let data = string.data(using: .utf8) else { return }
            messageHandler(data)
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        default:
            break
        }
    }
    
    private func handleRegistration(data: Data) {
        guard let registration = try? decoder.decode(Registration.self, from: data) else { return }
        view?.showRegistrationMessage(registration: registration)
    }
    
    private func handleUser(data: Data) {
        guard let user = try? decoder.decode(User.self, from: data) else { return }
        self.user = user
        inputTextProcessor = sendChatMessage
        messageHandler = handleIncomingMessage
    }
    
    private func handleIncomingMessage(data: Data) {
        guard let message = try? decoder.decode(IncomingMessage.self, from: data) else { return }
        view?.showMessage(message: message)
    }
    
    private func registerUser(nickName: String) {
        guard let accountData = try? encoder.encode(AccountData(nickName: nickName)) else { return }
        socket.write(data: accountData)
        messageHandler = handleUser
    }
    
    private func sendChatMessage(text: String) {
        let outgoingMessage = OutgoingMessage(type: "channel", target: "random", user: user, text: text, time: currentDateTime)
        guard let messageData = try? encoder.encode(outgoingMessage) else { return }
        socket.write(data: messageData)
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
    
    func sendMessage(text: String) {
        inputTextProcessor(text)
    }
    
    private var currentDateTime: String {
        return ISO8601DateFormatter().string(from: Date())
    }
}
