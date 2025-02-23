import Foundation

class ActorViewModel {
    var actorsResponse: Actor?
    var actors: [ActorData] = []
    var manager = ActorManager()
    
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    func getActors() {
        manager.getActorList(page: (actorsResponse?.page ?? 0) + 1) { data, errorMessage in
            if let errorMessage {
                self.errorHandling?(errorMessage)
            } else if let data {
                self.actorsResponse = data
                self.actors.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
    
    func pagination(index: Int) {
        if actors.count - 2 == index && (actorsResponse?.page ?? 0 < (actorsResponse?.totalPages ?? 0)) {
            getActors()
        }
    }
    
    func reset() {
        actors = []
        actorsResponse = nil
    }
}
