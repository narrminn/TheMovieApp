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
        manager.request(endpoint: .nowPlaying, model: Movie.self) { data, error in
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
        manager.request(endpoint: .topRated, model: Movie.self) { data, error in
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
        manager.request(endpoint: .upcoming, model: Movie.self) { data, error in
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
        manager.request(endpoint: .popular, model: Movie.self) { data, error in
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
