import UIKit

protocol ErrorPresentable where Self: UIViewController {
    func showErrorAlert(errorMessage: String)
}

extension ErrorPresentable {
    func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
