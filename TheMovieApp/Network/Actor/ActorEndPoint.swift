import Foundation

enum ActorEndPoint: String {
    case actors = "person/popular"
    
    var path: String {
        return NetworkHelper.shared.configureURL(endpoint: self.rawValue)
    }
}
