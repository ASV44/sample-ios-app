import Foundation

protocol LaunchDetailsViewInput: class {
    func setupHeaderView(headerViewModel: LaunchDetailsHeaderViewModel)
}

protocol LaunchDetailsViewOutput {
    func viewDidLoad()
    var sectionCount: Int { get }
    func rowCount(for section: Int) -> Int
    func launchCellModel(for indexPath: IndexPath) -> LaunchDetailsCellViewModel?
    func title(for section: Int) -> String?
}
