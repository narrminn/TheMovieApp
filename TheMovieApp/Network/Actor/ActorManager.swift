import Foundation

protocol ActorManagerUseCase {
    func getActorList(completion: @escaping((Actor?, String?) -> Void))
//    func getActorMovies(actorId: Int, completion: @escaping((Movie?, String?) -> Void))
}

class ActorManager: ActorManagerUseCase {
    var manager = NetworkManager()
    
    func getActorList(completion: @escaping((Actor?, String?) -> Void)) {
        let path = ActorEndPoint.actor.path
        manager.request(path: path, model: Actor.self, completion: completion)
    }
}
