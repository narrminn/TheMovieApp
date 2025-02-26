import Foundation

class SearchViewModel {
    var searchResponse: MovieSearch?
    var movies: [MovieSearchResult] = []
    
    var manager = MovieManager()
    
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    func movieSearch(query: String) {
        manager.searchMovie(page: (searchResponse?.page ?? 0) + 1, query: query) { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.searchResponse = data
                self.movies.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
    
    func pagination(index: Int, query: String) {
        if movies.count - 3 == index && (searchResponse?.page ?? 0 < (searchResponse?.totalPages ?? 0)) {
            movieSearch(query: query)
        }
    }
    
    func reset() {
        movies = []
        searchResponse = nil
    }
}
