struct OutgoingMessage: Codable {
    let type: String
    let target: String
    let sender: User
    let text: String
    let time: String
}
