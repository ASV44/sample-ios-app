import UIKit
import Reachability

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func openCollectionViewScreen() {
        let collectionVC = instantiateViewController(
            storyboardName: "CollectionViewExample",
            identifier: CollectionViewController.identifier,
            type: CollectionViewController.self
        )
        let collectionInteractor = CollectionInteractor(view: collectionVC, apiService: APICommunication(reachability: try? Reachability()))
        collectionVC.interactor = collectionInteractor

        navigationController?.pushViewController(collectionVC, animated: true)
    }

    @IBAction private func openChatScreen() {
        let chatVC = instantiateViewController(
            storyboardName: "ChatViewController",
            identifier: ChatViewController.identifier,
            type: ChatViewController.self
        )
        let interactor = ChatInteractor(view: chatVC)
        chatVC.interactor = interactor

        navigationController?.pushViewController(chatVC, animated: true)
    }
}
