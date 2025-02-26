import Foundation

class ActorMovieViewModel {
    var movies: [ActorMovieResult]?
    private var manager = ActorManager()
    
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    func getActorMovies(actorId: Int) {
        manager.getActorMovies(actorId: actorId){ data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.movies = data.cast
                self.success?()
            }
        }
    }
    
    func reset() {
        movies = []
    }
}
