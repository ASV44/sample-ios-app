import Foundation

struct Launch: Codable {
    let links: Links
    let staticFireDateUTC: String?
    let staticFireDateUnix: Double?
    let rocketID: String
    let success: Bool
    let details: String?
    let ships: [String]
    let launchpadID: String
    let flightNumber: Int
    let missionName: String
    let dateUTC: String
    let dateUnix: Double
    let dateLocal: String
    let upcoming: Bool
    let cores: [Core]
    let ID: String
    
    enum CodingKeys: String, CodingKey {
        case links
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case rocketID = "rocket"
        case success
        case details
        case ships
        case launchpadID = "launchpad"
        case flightNumber = "flight_number"
        case missionName = "name"
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case upcoming
        case cores
        case ID = "id"
    }
    
    struct Links: Codable {
        let patch: Patch
        let flickr: Flickr
        let webcast: URL
        let youtubeID: String
        let article: URL?
        let wikipedia: URL?
        
        enum CodingKeys: String, CodingKey {
            case patch
            case flickr
            case webcast
            case youtubeID = "youtube_id"
            case article
            case wikipedia
        }
        
        struct Patch: Codable {
            let small: URL?
            let large: URL?
        }
        
        struct Flickr: Codable {
            let original: [URL]
        }
    }
    
    struct Core: Codable {
        let coreID: String
        let flight: Int
        let gridfins: Bool
        let legs: Bool
        let reused: Bool
        let landingAttempt: Bool
        let landingSuccess: Bool?
        let landingType: String?
        let landpad: String?
        
        enum CodingKeys: String, CodingKey {
            case coreID = "core"
            case flight
            case gridfins
            case legs
            case reused
            case landingAttempt = "landing_attempt"
            case landingSuccess = "landing_success"
            case landingType = "landing_type"
            case landpad
        }
        
        func getCoreValue(for section: LaunchDetailsSection.Core) -> String {
            switch section {
            case .fligth:
                return "#\(flight)"
            case .gridfins:
                return String(gridfins)
            case .landingAttempt:
                return String(landingAttempt)
            case .landingSuccess:
                return String(landingSuccess) ?? ""
            case .landingType:
                return landingType ?? ""
            case .reused:
                return String(reused)
            }
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateStyle = DateFormatter.Style.medium
        
        return formatter.string(from: Date(timeIntervalSince1970: dateUnix))
    }
    
    func getFlightValue(for section: LaunchDetailsSection.Fligth) -> String {
        switch section {
        case .fligthNumber:
            return "#\(flightNumber)"
        case .launchDate:
            return formattedDate
        case .success:
            return String(success)
        }
    }
}

extension String {
    init?(_ value: Bool?) {
        guard let value = value else { return nil }
        self.init(value)
    }
}
