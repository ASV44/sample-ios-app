import RxSwift

final class CollectionInteractor: CollectionViewOutput {
    private let apiService: APIService
    private let disposeBag = DisposeBag()
    
    private weak var view: CollectionViewInput?
    
    init(view: CollectionViewInput, apiService: APIService) {
        self.view = view
        self.apiService = apiService
    }
    
    func viewDidLoad() {
        fetchPastLaunches()
    }
    
    private func fetchPastLaunches() {
        apiService.getLatestLaunches()
            .onSuccess { [weak self] launches in
                print(launches)
            }.onFailure { [weak self] error in
                print(error)
//                self?.onError(error: error)
            }.run().disposed(by: disposeBag)
    }
}
