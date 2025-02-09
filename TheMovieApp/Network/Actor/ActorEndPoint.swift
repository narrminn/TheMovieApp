import Foundation

enum ActorEndPoint {
    case actor
    case actorMovies(Id: Int)
    
    var path: String {
        switch self {
        case .actor:
            return NetworkHelper.shared.configureURL(endpoint: "person/popular")
        case .actorMovies(let id):
            return NetworkHelper.shared.configureURL(endpoint: "person/\(id)/movie_credits")
        }
    }
}
