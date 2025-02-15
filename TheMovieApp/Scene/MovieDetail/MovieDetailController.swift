import UIKit

class MovieDetailController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    
    private var viewModel = MovieDetailViewModel()
    
    var lastSelectedSegmentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(
            UINib(nibName: "\(MovieDetailHeaderReusableView.self)", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MovieDetailHeaderReusableView"
        )
    }
    
    func configure(id: Int) {
        viewModel.movieId = id
        viewModel.getMovieDetail()
    }
    
    fileprivate func configureViewModel() {
        viewModel.success = {
            self.collection.reloadData()
        }
        
        viewModel.errorHandling = { error in
            print(error)
        }
    }
}

extension MovieDetailController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieDetailHeaderReusableView", for: indexPath) as! MovieDetailHeaderReusableView
        
        header.segmentChangedAction = { selectedSegmentIndex in
            self.lastSelectedSegmentIndex = selectedSegmentIndex
            
            self.collection.reloadData()
        }
        
        if let movie = viewModel.movie {
            header.configure(movie: movie)
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 600)
    }
}
