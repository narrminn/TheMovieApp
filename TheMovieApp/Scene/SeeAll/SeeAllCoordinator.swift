import Foundation
import UIKit

class SeeAllCoordinator : Coordinator {
    var navigationController: UINavigationController
    var model: HomeModel
    var usecase: MovieManagerUseCase
    
    init(model: HomeModel, usecase: MovieManagerUseCase, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.model = model
        self.usecase = usecase
    }
    
    func start() {
        let controller = SeeAllController(viewModel: .init(model: model, usecase: usecase))
        
        self.navigationController.show(controller, sender: nil)
    }
}
