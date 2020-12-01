enum LaunchDetailsSection: String, CaseIterable {
    case fligth = "Flight"
    case rocket = "Rocket"
    case paylods = "Payload Weights"
    case core = "Core"

    enum Fligth: String, CaseIterable {
        case fligthNumber = "Flight Number"
        case launchDate = "Launch Date"
        case success = "Success"
    }
    
    enum Rocket: String, CaseIterable {
        case name = "Name"
        case type = "Type"
        case isActive = "Is Active"
        case stages = "Stages"
        case boosters = "Boosters"
        case costPerLlaunch = "Cost Per Launch"
        case successRate = "Success Rate"
        case firstFlight = "First Flight"
        case country = "Country"
        case company = "Company"
        case description = "Description"
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
