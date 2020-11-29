import Foundation

struct LaunchCellModel {
    let imageURL: URL?
    let success: Bool
    let details: String
    let flightNumber: Int
    let missionName: String
    let date: Date
    
    init(launch: Launch) {
        imageURL = launch.links.flickr.original.first
        success = launch.success
        details = launch.details ?? ""
        flightNumber = launch.flightNumber
        missionName = launch.missionName
        date = Date(timeIntervalSince1970: launch.dateUnix)
    }
    
    var formattedDate: String {
        return DateFormatter().string(from: date)
    }
}
