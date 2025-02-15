import Foundation

protocol ActorManagerUseCase {
    func getActorList(completion: @escaping((Actor?, String?) -> Void))
    func getActorMovies(actorId: Int, completion: @escaping((ActorMovie?, String?) -> Void))
}

class ActorManager: ActorManagerUseCase {
    var manager = NetworkManager()
    
    func getActorList(completion: @escaping((Actor?, String?) -> Void)) {
        let path = ActorEndPoint.actor.path
        manager.request(path: path, model: Actor.self, completion: completion)
    }
    
    func getActorMovies(actorId: Int, completion: @escaping ((ActorMovie?, String?) -> Void)) {
        let path = ActorEndPoint.actorMovies(Id: actorId).path
        manager.request(path: path, model: ActorMovie.self, completion: completion)
    }
}
