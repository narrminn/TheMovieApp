import UIKit

class SeeAllController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    
    private var viewModel = SeeAllViewModel()
    private var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        configureUI()
    }
    
    func configure(movies: [MovieResult]) {
        viewModel.movies = movies
    }
    
    fileprivate func configureUI() {
        collection.dataSource = self
        collection.delegate = self
        
        collection.register(ImageLabelCell.self, forCellWithReuseIdentifier: "ImageLabelCell")
    }
}

extension SeeAllController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLabelCell", for: indexPath) as! ImageLabelCell
        cell.configure(data: viewModel.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "\(MovieDetailController.self)") as! MovieDetailController
        
        controller.configure(id: viewModel.movies[indexPath.row].id ?? 0)
        
        navigationController?.show(controller, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collection.frame.width - 16
//        return CGSize(width: width, height: 540)
        .init(width: (collectionView.frame.width - 40) / 2, height: 280)
    }
}
