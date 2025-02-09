import Foundation

struct HomeModel {
    var title: String
    var items: [MovieResult]?
}

class HomeViewModel {
    var movieItems = [HomeModel]()
    var manager = NetworkManager()
    
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    func getAllData() {
        getNowPlaying()
        getTopRated()
        getUpcoming()
        getPopular()
    }
    
    func getNowPlaying() {
        var path = MovieEndPoint.nowPlaying.path
        manager.request(path: path, model: Movie.self) { data, error in
            if let error {
                self.errorHandling?(error)
            } else if let data {
                self.movieItems.append(.init(title: "Now Playing",
                                             items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func getTopRated() {
        var path = MovieEndPoint.topRated.path
        manager.request(path: path, model: Movie.self) { data, error in
            if let error {
                self.errorHandling?(error)
            } else if let data {
                self.movieItems.append(.init(title: "Top Rated",
                                             items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func getUpcoming() {
        var path = MovieEndPoint.upcoming.path
        manager.request(path: path, model: Movie.self) { data, error in
            if let error {
                self.errorHandling?(error)
            } else if let data {
                self.movieItems.append(.init(title: "Upcoming",
                                             items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func getPopular() {
        var path = MovieEndPoint.popular.path
        manager.request(path: path, model: Movie.self) { data, error in
            if let error {
                self.errorHandling?(error)
            } else if let data {
                self.movieItems.append(.init(title: "Popular",
                                             items: data.results ?? []))
                self.success?()
            }
        }
    }
    
}
