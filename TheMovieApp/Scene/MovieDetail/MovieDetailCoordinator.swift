import Foundation
import UIKit

class MovieDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var movieId: Int
    
    init(movieId: Int, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.movieId = movieId
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(MovieDetailController.self)") as! MovieDetailController
        controller.configure(id: movieId)
        
        self.navigationController.show(controller, sender: nil)
    }
    
}

