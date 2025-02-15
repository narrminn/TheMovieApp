import Foundation

class MovieDetailViewModel {
    var movie: MovieDetail?
    var movieId: Int?
    
    private var manager = MovieManager()
    
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    func getMovieDetail() {
        if let movieId = movieId {
            manager.getDetail(id: movieId) { data, errorMessage in
                if let errorMessage {
                    self.errorHandling?(errorMessage)
                } else if let data {
                    self.movie = data
                    self.success?()
                }
            }
        }
    }
}
