import UIKit

final class ChatViewController: UIViewController, ChatViewInput {
    
    var interactor: ChatViewOutput!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.viewDidLoad()
    }
}
