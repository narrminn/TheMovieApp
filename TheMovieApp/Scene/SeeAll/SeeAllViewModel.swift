import Foundation

class SeeAllViewModel {
    var model: HomeModel
    var movie: Movie?
    var usecase: MovieManagerUseCase
    
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    init(model: HomeModel, usecase: MovieManagerUseCase) {
        self.model = model
        self.usecase = usecase
    }
    
    func getMovieItems() {
        usecase.getMovieList(page: (movie?.page ?? 1) + 1,
                             endpoint: model.endpoint) { movie, error in
            if let error {
                self.errorHandling?(error)
            } else if let movie {
                self.movie = movie
                self.model.items.append(contentsOf: movie.results ?? [])
                self.success?()
            }
        }
    }
    
    func pagination(index: Int) {
        if index == model.items.count-2 && (movie?.page ?? 1 <= movie?.totalPages ?? 1) {
            getMovieItems()
        }
    }
}
