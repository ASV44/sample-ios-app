import UIKit

final class ChatViewController: UIViewController, ChatViewInput {
    @IBOutlet private var messageTextLabel: UILabel!
    @IBOutlet private var inputTextField: UITextField!
    
    var interactor: ChatViewOutput!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.viewDidLoad()
    }
    
    func showRegistrationMessage(registration: Registration) {
        messageTextLabel.text = registration.text
    }
    
    @IBAction private func sendButtonTap() {
        
    }
    
    func showMessage(message: IncomingMessage) {
        messageTextLabel.text = message.text
    }
}
