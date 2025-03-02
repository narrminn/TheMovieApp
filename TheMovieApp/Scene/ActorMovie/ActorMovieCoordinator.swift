import Foundation
import UIKit

class ActorMovieCoordinator : Coordinator {
    var navigationController: UINavigationController
    var actorId: Int
    var name: String
    
    init(actorId: Int, name: String, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.actorId = actorId
        self.name = name
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(ActorMovieController.self)") as! ActorMovieController
        controller.configure(actorId: actorId)
        controller.configureNav(name: name)
        
        self.navigationController.show(controller, sender: nil)
    }
}
