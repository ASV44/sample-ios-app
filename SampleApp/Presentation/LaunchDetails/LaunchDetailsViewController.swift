import UIKit

final class LaunchDetailsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    
    private let launchDetailsHeaderView = LaunchDetailsHeaderView.instantiate()
    
    var interactor: LaunchDetailsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = launchDetailsHeaderView
        interactor.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureTableViewHeader()
    }
    
    private func configureTableViewHeader() {
        let contentSize = tableView.contentSize.height - launchDetailsHeaderView.frame.size.height
        let heightScaleFactor: CGFloat = 0.8
        let descriptionHeightConstant: CGFloat = 120
        launchDetailsHeaderView.frame.size = CGSize(
            width: launchDetailsHeaderView.frame.size.width,
            height: heightScaleFactor * launchDetailsHeaderView.frame.size.width + descriptionHeightConstant
        )
        tableView.contentSize.height = launchDetailsHeaderView.frame.size.height + contentSize
    }
}

extension LaunchDetailsViewController: LaunchDetailsViewInput {
    func setupHeaderView(headerViewModel: LaunchDetailsHeaderViewModel) {
        launchDetailsHeaderView.setup(with: headerViewModel)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoadingIndecator() {
        loadingIndicator.isHidden = false
    }

    func hideLoadingIndecator() {
        loadingIndicator.isHidden = true
    }
    
    func showTableView() {
        tableView.isHidden = false
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
