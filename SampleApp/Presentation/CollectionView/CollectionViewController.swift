import UIKit

final class CollectionViewController: UIViewController, CollectionViewInput {
    var interactor: CollectionViewOutput!

    static var identifier: String {
        return String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.viewDidLoad()
    }
}
