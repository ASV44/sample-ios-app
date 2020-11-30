import UIKit

final class LaunchDetailsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    private let launchDetailsHeaderView = LaunchDetailsHeaderView.instantiate()
    
    var interactor: LaunchDetailsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = launchDetailsHeaderView
        interactor.viewDidLoad()
    }
}

extension LaunchDetailsViewController: LaunchDetailsViewInput {
    func setupHeaderView(headerViewModel: LaunchDetailsHeaderViewModel) {
        launchDetailsHeaderView.setup(with: headerViewModel)
    }
}

extension LaunchDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.rowCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = interactor.launchCellModel(for: indexPath) else { return UITableViewCell() }
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = cellModel.name
        cell.detailTextLabel?.text = cellModel.value
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return interactor.title(for: section)
    }
}
