struct Url {
    private struct Domains {
        static let Dev = "https://api.spacexdata.com"
        static let QA = ""
    }
    
    private  struct Routes {
        static let APIVersion = "/v4"
    }
    
    private  static let Domain = Domains.Dev
    private  static let Route = Routes.APIVersion
    private  static let BaseURL = Domain + Route
    
    static var launchesPast: String {
        return BaseURL  + "/launches/past"
    }
    
    static var rockets: String {
        return BaseURL + "/rockets"
    }
}
