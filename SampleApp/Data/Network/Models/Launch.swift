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
}
