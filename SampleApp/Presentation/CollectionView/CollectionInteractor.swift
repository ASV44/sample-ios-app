import RxSwift

final class CollectionInteractor {
    private let apiService: APIService
    private var launches = [Launch]()
    private var cellModels = [LaunchCellModel]()
    private let disposeBag = DisposeBag()
    
    private weak var view: CollectionViewInput?
    
    init(view: CollectionViewInput, apiService: APIService) {
        self.view = view
        self.apiService = apiService
    }
    
    private func fetchPastLaunches() {
        apiService.getLatestLaunches()
            .onSubscribe { [weak self] in
                self?.view?.showLoadingIndecator()
            }.onSuccess { [weak self] launches in
                self?.handleLaunchesData(launches: launches)
            }.onFailure { [weak self] error in
                self?.handleException(errorPresentable: self?.view, error: error)
            }.onDispose { [weak self] in
                self?.view?.hideLoadingIndecator()
            }.run().disposed(by: disposeBag)
    }
    
    private func handleLaunchesData(launches: [Launch]) {
        self.launches = launches
        cellModels = launches.map(LaunchCellModel.init)
        view?.reloadData()
    }
}

extension CollectionInteractor: CollectionViewOutput {
    func viewDidLoad() {
        fetchPastLaunches()
    }
    
    var launchesCount: Int {
        return launches.count
    }
    
    func cellModel(at indexPath: IndexPath) -> LaunchCellModel? {
        return cellModels[safe: indexPath.item]
    }
}
