import Foundation

struct Rocket: Codable {
    let payloadWeights: [PayloadWeights]
    let name: String
    let type: String
    let isActive: Bool
    let stages: Int
    let boosters: Int
    let costPerLlaunch: Double
    let successRate: Double
    let firstFlight: String
    let country: String
    let company: String
    let description: String
    let ID: String
    
    enum CodingKeys: String, CodingKey {
        case payloadWeights = "payload_weights"
        case name
        case type
        case isActive = "active"
        case stages
        case boosters
        case costPerLlaunch = "cost_per_launch"
        case successRate = "success_rate_pct"
        case firstFlight = "first_flight"
        case country
        case company
        case description
        case ID = "id"
    }
    
    struct PayloadWeights: Codable {
        let ID: String
        let name: String
        let kg: Int
        let lb: Int
        
        enum CodingKeys: String, CodingKey {
            case ID = "id"
            case name
            case kg
            case lb
        }
    }
    
    func getRocketValue(for section: LaunchDetailsSection.Rocket) -> String {
        switch section {
            case .name:
                return name
            case .type:
                return type
            case .isActive:
                return String(isActive)
            case .stages:
                return "\(stages)"
            case .boosters:
                return "\(boosters)"
            case .costPerLlaunch:
                return "\(costPerLlaunch)$"
            case .successRate:
                return "\(successRate)"
            case .firstFlight:
                return firstFlight
            case .country:
                return country
            case .company:
                return company
            case .description:
                return description
        }
    }
}
