import Foundation

struct LaunchCellModel {
    let imageURL: URL?
    let success: Bool
    let flightNumber: Int
    let missionName: String
    let date: String
    
    init(launch: Launch) {
        imageURL = launch.links.flickr.original.first
        success = launch.success
        flightNumber = launch.flightNumber
        missionName = launch.missionName
        date = launch.formattedDate
    }
}
