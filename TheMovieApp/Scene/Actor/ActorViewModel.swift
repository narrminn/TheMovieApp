import Foundation

class ActorViewModel {
    var actors: [ActorData] = []
    var manager = ActorManager()
    
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    func getActors() {
        manager.getActorList { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.actors = data.results ?? []
                self.success?()
            }
        }
    }
}
