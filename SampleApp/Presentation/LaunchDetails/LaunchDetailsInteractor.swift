import Foundation

final class LaunchDetailsInteractor {
    private let launch: Launch
    private var cellModel: [LaunchDetailsSection: [LaunchDetailsCellViewModel]] = [:]
    
    private weak var view: LaunchDetailsViewInput?
    
    init(view: LaunchDetailsViewInput, launch: Launch) {
        self.view = view
        self.launch = launch
        
        generateCellModels(launch: launch)
    }
    
    private func generateCellModels(launch: Launch) {
        for section in LaunchDetailsSection.allCases {
            switch section {
            case .fligth:
                cellModel[.fligth] = generateFlighCells(launch: launch)
            case .core:
                guard let core = launch.cores.first else { return }
                cellModel[.core] = generateCoreCell(core: core)
            }
        }
    }
    
    private func generateFlighCells(launch: Launch) -> [LaunchDetailsCellViewModel] {
        LaunchDetailsSection.Fligth.allCases.map { LaunchDetailsCellViewModel(name: $0.rawValue, value: launch.getFlightValue(for: $0)) }
    }
    
    private func generateCoreCell(core: Launch.Core) -> [LaunchDetailsCellViewModel] {
        LaunchDetailsSection.Core.allCases.map { LaunchDetailsCellViewModel(name: $0.rawValue, value: core.getCoreValue(for: $0)) }
    }
}

extension LaunchDetailsInteractor: LaunchDetailsViewOutput {
    func viewDidLoad() {
        view?.setupHeaderView(
            headerViewModel: LaunchDetailsHeaderViewModel(videoID: launch.links.youtubeID,
                                                          description: launch.details ?? "")
        )
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
