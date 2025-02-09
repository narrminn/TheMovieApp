import Foundation

class ActorViewModel {
    var actors: [ActorData] = []
    var manager = NetworkManager()
    
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    func getActors() {
        var path = ActorEndPoint.actors.path
        manager.request(path: path, model: Actor.self) { data, error in
            if let error {
                self.errorHandling?(error)
            } else if let data {
                self.actors.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
}
