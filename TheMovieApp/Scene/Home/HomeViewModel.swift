import Foundation

struct HomeModel {
    var title: String
    var items: [MovieResult]?
}

class HomeViewModel {
    var movieItems = [HomeModel]()
    var manager = MovieManager()
    
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    func getAllData() {
        getNowPlaying()
        getTopRated()
        getUpcoming()
        getPopular()
    }
    
    func getNowPlaying() {
        manager.getNowPlaying { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.movieItems.append(.init(title: "Now Playing",
                                             items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func getTopRated() {
        manager.getTopRated { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.movieItems.append(.init(title: "Top Rated",
                                             items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func getUpcoming() {
        manager.getUpcoming { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.movieItems.append(.init(title: "Upcoming",
                                             items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func getPopular() {
        manager.getPopular { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.movieItems.append(.init(title: "Popular",
                                             items: data.results ?? []))
                self.success?()
            }
        }
    }
    
}
