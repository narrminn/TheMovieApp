import UIKit

class ActorController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    
    private var viewModel = ActorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        configureUI()
    }
    
    fileprivate func configureUI() {
        collection.dataSource = self
        collection.delegate = self
        
        collection.register(ImageLabelCell.self, forCellWithReuseIdentifier: "ImageLabelCell")
    }
    
    func configureViewModel() {
        navigationItem.title = "Actors"
        
        viewModel.getActors()
        
        viewModel.success = {
            self.collection.reloadData()
        }
        
        viewModel.errorHandling = { error in
            print(error)
        }
    }
}

extension ActorController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLabelCell", for: indexPath) as! ImageLabelCell
        cell.configure(data: viewModel.actors[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: (collectionView.frame.width - 40) / 2, height: 220)
    }
}
