import UIKit

class SearchController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var viewModel = SearchViewModel()
    
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
    
    @IBAction func searchAction(_ sender: Any) {
        viewModel.movieSearch(query: searchTextField.text ?? "")
    }
    
    fileprivate func configureViewModel() {
        navigationItem.title = "Search"
        
        viewModel.success = {
            self.collection.reloadData()
            self.refreshController.endRefreshing()
        }
        
        viewModel.errorHandling = { error in
            print(error)
            self.refreshController.endRefreshing()
        }
    }
    
    @objc func pullToRefresh() {
        viewModel.reset()
        collection.reloadData()
        viewModel.movieSearch(query: searchTextField.text ?? "")
    }
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLabelCell", for: indexPath) as! ImageLabelCell
        cell.configure(data: viewModel.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let controller = storyboard?.instantiateViewController(identifier: "\(MovieDetailController.self)") as! MovieDetailController
//        if let movieId = viewModel.movies[indexPath.row].id {
//            controller.configure(id: movieId)
//        }
//        navigationController?.show(controller, sender: nil)
        
        if let movieId = viewModel.movies[indexPath.row].id {
            let coordinator = MovieDetailCoordinator(movieId: movieId, navigationController: self.navigationController ?? UINavigationController())
            
            coordinator.start()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.row, query: searchTextField.text ?? "")
    }
}

