import Foundation

enum MovieEndPoint {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case movieDetails(id: Int)
    
    var path: String {
        switch self {
        case .nowPlaying:
            return NetworkHelper.shared.configureURL(endpoint: "movie/now_playing")
        case .popular:
            return NetworkHelper.shared.configureURL(endpoint: "movie/popular")
        case .topRated:
            return NetworkHelper.shared.configureURL(endpoint: "movie/top_rated")
        case .upcoming:
            return NetworkHelper.shared.configureURL(endpoint: "movie/upcoming")
        case .movieDetails(let id):
            return NetworkHelper.shared.configureURL(endpoint: "movie/\(id)")
        }
        
    }
}
