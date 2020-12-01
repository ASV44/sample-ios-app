enum LaunchDetailsSection: String, CaseIterable {
    case fligth = "Flight"
    case core = "Core"

    enum Fligth: String, CaseIterable {
        case fligthNumber = "Flight Number"
        case launchDate = "Launch Date"
        case success = "Success"
    }

    enum Core: String, CaseIterable {
        case fligth = "Flight"
        case gridfins = "Gridfins"
        case reused = "Reused"
        case landingAttempt = "Landing Attempt"
        case landingSuccess = "Landing Success"
        case landingType = "Landing Type"
    }
}
