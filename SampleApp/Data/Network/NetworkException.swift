import Foundation

enum Exception: Error {
    case NetworkConnection
    case HTTP(error: Error, data: Data?)
}
