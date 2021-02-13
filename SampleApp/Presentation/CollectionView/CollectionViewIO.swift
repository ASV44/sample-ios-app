import UIKit

protocol CollectionViewInput: ErrorPresentable {
    func showLoadingIndecator()
    func hideLoadingIndecator()
    func reloadData()
    func presentLaunchDetailsScreen(launch: Launch)
}

protocol CollectionViewOutput: ExceptionHandler {
    func viewDidLoad()
    var launchesCount: Int { get }
    func cellModel(at indexPath: IndexPath) -> LaunchCellModel?
    func didSelectItem(indexPath: IndexPath)
}
