import UIKit

class ActorMovieController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    
    var viewModel = ActorMovieViewModel()
    var actorId: Int?
    
    let refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        collection.dataSource = self
        collection.delegate = self
        
        refreshController.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        collection.refreshControl = refreshController
        
        collection.register(ImageLabelCell.self, forCellWithReuseIdentifier: "ImageLabelCell")
    }
    
    func configure(actorId: Int) {
        self.actorId = actorId
        viewModel.getActorMovies(actorId: actorId)
    }
    
    fileprivate func configureViewModel() {
        viewModel.success = {
            self.collection.reloadData()
            self.refreshController.endRefreshing()
        }
        
        viewModel.errorHandling = { error in
            print(error)
            self.refreshController.endRefreshing()
        }
    }
    
    func configureNav(name: String) {
        navigationItem.title = "\(name) movies"
    }
    
    @objc func pullToRefresh() {
        viewModel.reset()
        collection.reloadData()
        viewModel.getActorMovies(actorId: actorId ?? 0)
    }
}

extension ActorMovieController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLabelCell", for: indexPath) as! ImageLabelCell
        
        if let movie = viewModel.movies?[indexPath.row] {
            cell.configure(data: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: (collectionView.frame.width - 40) / 2, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieId = viewModel.movies?[indexPath.row].id {
            let coordinator = MovieDetailCoordinator(movieId: movieId, navigationController: self.navigationController ?? UINavigationController())
            
            coordinator.start()
        }
    }
}
