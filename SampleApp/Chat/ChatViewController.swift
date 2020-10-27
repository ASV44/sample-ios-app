import UIKit

final class ChatViewController: UIViewController, ChatViewInput {
    @IBOutlet private var messageTextLabel: UILabel!
    @IBOutlet private var inputTextField: UITextField!
    @IBOutlet private var messageInputBottomConstraint: NSLayoutConstraint!
    
    var interactor: ChatViewOutput!
    
    private let keyboard: KeyboardType = Keyboard()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        keyboard.subscribe(self)
        interactor.viewDidLoad()
    }
    
    private func setupView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    func showRegistrationMessage(registration: Registration) {
        messageTextLabel.text = registration.text
    }
    
    @IBAction private func sendButtonTap() {
        guard let text = inputTextField.text else { return }
        interactor.sendMessage(text: text)
        inputTextField.text = ""
    }
    
    func showMessage(message: IncomingMessage) {
        messageTextLabel.text = message.text
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension ChatViewController: KeyboardObserver {
    func keyboardWillShow(info: KeyboardInfo) {
        messageInputBottomConstraint.constant = info.finalFrame.height
        UIViewPropertyAnimator(duration: info.duration, curve: info.curve) { [weak self] in
            self?.view.layoutIfNeeded()
        }.startAnimation()
    }
    
    func keyboardWillHide(info: KeyboardInfo) {
        messageInputBottomConstraint.constant = 0
        UIViewPropertyAnimator(duration: info.duration, curve: info.curve) { [weak self] in
            self?.view.layoutIfNeeded()
        }.startAnimation()
    }
}
