struct OutgoingMessage: Codable {
    let type: String
    let target: String
    let user: User
    let text: String
    let time: String
}
