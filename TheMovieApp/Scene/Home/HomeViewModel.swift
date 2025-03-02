import Foundation

enum HomeSectionTitle: String {
    case popular = "Popular"
    case upcoming = "Upcoming"
    case toprated = "Top Rated"
    case nowplaying = "Now Playing"
}

struct HomeModel {
    var title: HomeSectionTitle
    var items: [MovieResult]
    var endpoint: MovieEndPoint
}

class HomeViewModel {
    var movieResponse: Movie?
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
        manager.getMovieList(page: (movieResponse?.page ?? 0) + 1, endpoint: .nowPlaying) { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.movieResponse = data
                self.movieItems.append(.init(title: .nowplaying,
                                             items: data.results ?? [],
                                             endpoint: .nowPlaying))
                self.success?()
            }
        }
    }
    
    func getTopRated() {
        manager.getMovieList(page: (movieResponse?.page ?? 0) + 1, endpoint: .topRated) { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.movieResponse = data
                self.movieItems.append(.init(title: .toprated,
                                             items: data.results ?? [],
                                             endpoint: .topRated))
                self.success?()
            }
        }
    }
    
    func getUpcoming() {
        manager.getMovieList(page: (movieResponse?.page ?? 0) + 1, endpoint: .upcoming) { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.movieResponse = data
                self.movieItems.append(.init(title: .upcoming,
                                             items: data.results ?? [],
                                             endpoint: .upcoming))
                self.success?()
            }
        }
    }
    
    func getPopular() {
        manager.getMovieList(page: (movieResponse?.page ?? 0) + 1, endpoint: .popular) { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.movieResponse = data
                self.movieItems.append(.init(title: .popular,
                                             items: data.results ?? [],
                                             endpoint: .popular))
                self.success?()
            }
        }
    }
}
