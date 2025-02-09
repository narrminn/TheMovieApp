import UIKit

class SeeAllController: UIViewController {
    
    private var viewModel = SeeAllViewModel()

    override func viewDidLoad() {
    }
    
    func configure(movies: [MovieResult]) {
        viewModel.movies = movies
    }
}
