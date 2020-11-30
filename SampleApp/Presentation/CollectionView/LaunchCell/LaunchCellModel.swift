import Foundation

struct LaunchCellModel {
    let imageURL: URL?
    let success: Bool
    let flightNumber: Int
    let missionName: String
    let date: Date
    
    init(launch: Launch) {
        imageURL = launch.links.flickr.original.first
        success = launch.success
        flightNumber = launch.flightNumber
        missionName = launch.missionName
        date = Date(timeIntervalSince1970: launch.dateUnix)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateStyle = DateFormatter.Style.medium
        
        return formatter.string(from: date)
    }
}
