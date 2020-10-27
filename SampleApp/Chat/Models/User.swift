struct User: Codable {
    let ID: Int
    var nickName: String
    
    init(ID: Int, nickName: String = "") {
        self.ID = ID
        self.nickName = nickName
    }
}
