import RxSwift

final class LaunchDetailsInteractor {
    private let apiService: APIService
    private let launch: Launch
    private var cellModel: [LaunchDetailsSection: [LaunchDetailsCellViewModel]] = [:]
    private let disposeBag = DisposeBag()
    
    private weak var view: LaunchDetailsViewInput?
    
    init(view: LaunchDetailsViewInput, apiService: APIService, launch: Launch) {
        self.view = view
        self.apiService = apiService
        self.launch = launch
    }
    
    private func generateCellModels(launch: Launch, rocket: Rocket) {
        for section in LaunchDetailsSection.allCases {
            switch section {
            case .fligth:
                cellModel[.fligth] = generateFlighCells(launch: launch)
            case .rocket:
                cellModel[.rocket] = generateRocketCells(rocket: rocket)
            case .paylods:
                cellModel[.paylods] = generatePayloadsCells(payloads: rocket.payloadWeights)
            case .core:
                guard let core = launch.cores.first else { return }
                cellModel[.core] = generateCoreCell(core: core)
            }
        }
    }
    
    private func generateFlighCells(launch: Launch) -> [LaunchDetailsCellViewModel] {
        LaunchDetailsSection.Fligth.allCases.map { LaunchDetailsCellViewModel(name: $0.rawValue, value: launch.getFlightValue(for: $0)) }
    }
    
    private func generateRocketCells(rocket: Rocket) -> [LaunchDetailsCellViewModel] {
        return LaunchDetailsSection.Rocket.allCases.map { LaunchDetailsCellViewModel(name: $0.rawValue, value: rocket.getRocketValue(for: $0)) }
    }
    
    private func generatePayloadsCells(payloads: [Rocket.PayloadWeights]) -> [LaunchDetailsCellViewModel] {
        return payloads.map { LaunchDetailsCellViewModel(name: $0.name, value: "\($0.kg) KG") }
    }
    
    private func generateCoreCell(core: Launch.Core) -> [LaunchDetailsCellViewModel] {
        LaunchDetailsSection.Core.allCases.map { LaunchDetailsCellViewModel(name: $0.rawValue, value: core.getCoreValue(for: $0)) }
    }
    
    private func fetchRocket(id: String) {
        apiService.getRocket(id: id)
            .onSubscribe { [weak self] in
                self?.view?.showLoadingIndecator()
            }.onSuccess { [weak self] rocket in
                self?.handleRocketData(rocket: rocket)
            }.onFailure { [weak self] error in
                self?.handleException(errorPresentable: self?.view, error: error)
            }.onDispose { [weak self] in
                self?.view?.hideLoadingIndecator()
            }.run().disposed(by: disposeBag)
    }
    
    private func handleRocketData(rocket: Rocket) {
        generateCellModels(launch: launch, rocket: rocket)
        view?.reloadData()
        view?.showTableView()
    }
}

extension LaunchDetailsInteractor: LaunchDetailsViewOutput {
    func viewDidLoad() {
        view?.setupHeaderView(
            headerViewModel: LaunchDetailsHeaderViewModel(videoID: launch.links.youtubeID,
                                                          description: launch.details ?? "")
        )
        fetchRocket(id: launch.rocketID)
    }
    
    var sectionCount: Int {
        return LaunchDetailsSection.allCases.count
    }
    
    func rowCount(for section: Int) -> Int {
        guard let launchSection = LaunchDetailsSection.allCases[safe: section] else { return 0 }
        return cellModel[launchSection]?.count ?? 0
    }
    
    func launchCellModel(for indexPath: IndexPath) -> LaunchDetailsCellViewModel? {
        guard let launchSection = LaunchDetailsSection.allCases[safe: indexPath.section] else { return nil }
        return cellModel[launchSection]?[safe: indexPath.row]
    }
    
    func title(for section: Int) -> String? {
        return LaunchDetailsSection.allCases[safe: section]?.rawValue
    }
}
