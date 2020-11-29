import UIKit

protocol CollectionViewInput: ErrorPresentable {
    func reloadData()
}

protocol CollectionViewOutput: ExceptionHandler {
    func viewDidLoad()
    var launchesCount: Int { get }
    func cellModel(at indexPath: IndexPath) -> LaunchCellModel?
}
