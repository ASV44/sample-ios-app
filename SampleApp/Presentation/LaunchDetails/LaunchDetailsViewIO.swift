import Foundation

protocol LaunchDetailsViewInput: ErrorPresentable {
    func setupHeaderView(headerViewModel: LaunchDetailsHeaderViewModel)
    func reloadData()
    func showLoadingIndecator()
    func hideLoadingIndecator()
    func showTableView()
}

protocol LaunchDetailsViewOutput: ExceptionHandler {
    func viewDidLoad()
    var sectionCount: Int { get }
    func rowCount(for section: Int) -> Int
    func launchCellModel(for indexPath: IndexPath) -> LaunchDetailsCellViewModel?
    func title(for section: Int) -> String?
}
