import Foundation

enum MovieEndPoint: String {
    case nowPlaying = "movie/now_playing"
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    
    var path: String {
        return NetworkHelper.shared.configureURL(endpoint: self.rawValue)
    }
}
