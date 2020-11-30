enum LaunchDetailsSection: String, CaseIterable {
    case fligth
    case core

    enum Fligth: String, CaseIterable {
        case fligthNumber
        case launchDate
        case success
    }

    enum Core: String, CaseIterable {
        case fligth
        case gridfins
        case reused
        case landingAttempt
        case landingSuccess
        case landingType
    }
}
