import UIKit

extension UIViewController {
    func instantiateViewController<T: UIViewController>(storyboardName: String,
                                                                identifier: String,
                                                                type: T.Type) -> T {
        let storyboard: UIStoryboard = UIStoryboard(
            name: storyboardName,
            bundle: Bundle(for: type)
        )

        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Could not instantiate \(identifier) from storyboard file.")
        }

        viewController.modalPresentationStyle = .fullScreen

        return viewController
    }
}

extension UIViewController: Identifiable { }
