protocol ChatViewInput: class {
    func showRegistrationMessage(registration: Registration)
    func showMessage(message: IncomingMessage)
}

protocol ChatViewOutput {
    func viewDidLoad()
    func sendMessage(text: String)
}
