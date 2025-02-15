import Foundation

protocol MovieManagerUseCase {
    func getNowPlaying(completion: @escaping((Movie?, String?) -> Void))
    func getPopular(completion: @escaping((Movie?, String?) -> Void))
    func getTopRated(completion: @escaping((Movie?, String?) -> Void))
    func getUpcoming(completion: @escaping((Movie?, String?) -> Void))
    func getDetail(id: Int, completion: @escaping((MovieDetail?, String?) -> Void))
}

class MovieManager: MovieManagerUseCase {
    var manager = NetworkManager()
    
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
}

