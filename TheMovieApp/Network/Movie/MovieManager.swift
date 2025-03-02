import Foundation

protocol MovieManagerUseCase {
    func getMovieList(page: Int, endpoint: MovieEndPoint, completion: @escaping((Movie?, String?) -> Void))
    func getNowPlaying(completion: @escaping((Movie?, String?) -> Void))
    func getPopular(completion: @escaping((Movie?, String?) -> Void))
    func getTopRated(completion: @escaping((Movie?, String?) -> Void))
    func getUpcoming(completion: @escaping((Movie?, String?) -> Void))
    func getDetail(id: Int, completion: @escaping((MovieDetail?, String?) -> Void))
    func getSimilar(id: Int, completion: @escaping((SimilarMovie?, String?) -> Void))
    func searchMovie(page: Int, query: String, completion: @escaping((MovieSearch?, String?) -> Void))
}

class MovieManager: MovieManagerUseCase {
    var manager = NetworkManager()
    
    func getMovieList(page: Int, endpoint: MovieEndPoint, completion: @escaping((Movie?, String?) -> Void)) {
        var path = ""
        switch endpoint {
        case .nowPlaying:
            path = MovieEndPoint.nowPlaying.path
        case .popular:
            path = MovieEndPoint.popular.path
        case .topRated:
            path = MovieEndPoint.topRated.path
        case .upcoming:
            path = MovieEndPoint.upcoming.path
        default:
            path = ""
        }
        
        let params = ["page" : page]
        
        manager.request(path: path, model: Movie.self, params: params, completion: completion)
    }
    
    func getNowPlaying(completion: @escaping((Movie?, String?) -> Void)) {
        let path = MovieEndPoint.nowPlaying.path
        manager.request(path: path, model: Movie.self, completion: completion)
    }
    
    func getPopular(completion: @escaping((Movie?, String?) -> Void)) {
        let path = MovieEndPoint.popular.path
        manager.request(path: path, model: Movie.self, completion: completion)
    }
    
    func getTopRated(completion: @escaping((Movie?, String?) -> Void)) {
        let path = MovieEndPoint.topRated.path
        manager.request(path: path, model: Movie.self, completion: completion)
    }
    
    func getUpcoming(completion: @escaping((Movie?, String?) -> Void)) {
        let path = MovieEndPoint.upcoming.path
        manager.request(path: path, model: Movie.self, completion: completion)
    }
    
    func getDetail(id: Int, completion: @escaping((MovieDetail?, String?) -> Void)) {
        let path = MovieEndPoint.movieDetails(id: id).path
        manager.request(path: path, model: MovieDetail.self, completion: completion)
    }
    
    func getSimilar(id: Int, completion: @escaping((SimilarMovie?, String?) -> Void)) {
        let path = MovieEndPoint.movieSimilar(id: id).path
        manager.request(path: path, model: SimilarMovie.self, completion: completion)
    }
    
    func searchMovie(page: Int, query: String, completion: @escaping((MovieSearch?, String?) -> Void)) {
        let path = MovieEndPoint.movieSearch.path
        let params: [String: Any] = ["query": query, "page": page]
        manager.request(path: path, model: MovieSearch.self, params: params, completion: completion)
    }
}

