import UIKit

protocol CollectionViewInput: ErrorPresentable {
    func showLoadingIndecator()
    func hideLoadingIndecator()
    func reloadData()
}

protocol CollectionViewOutput: ExceptionHandler {
    func viewDidLoad()
    var launchesCount: Int { get }
    func cellModel(at indexPath: IndexPath) -> LaunchCellModel?
}
