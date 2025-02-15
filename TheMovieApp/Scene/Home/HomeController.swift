import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        collection.dataSource = self
        collection.delegate = self
        
        collection.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
    }
    
    fileprivate func configureViewModel() {
        viewModel.getAllData()
        
        viewModel.success = {
            self.collection.reloadData()
        }
        
        viewModel.errorHandling = { error in
            print(error)
        }
    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        cell.configure(title: viewModel.movieItems[indexPath.row].title, data: viewModel.movieItems[indexPath.row].items ?? [])
        cell.seeAllCallBack = {
            let controller = self.storyboard?.instantiateViewController(identifier: "\(SeeAllController.self)") as! SeeAllController
            controller.configure(movies: self.viewModel.movieItems[indexPath.row].items ?? [])
            
            self.navigationController?.show(controller, sender: nil)
        }
        
        cell.detailCallBack = { id in
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "\(MovieDetailController.self)") as! MovieDetailController
            controller.configure(id: id)
            
            self.navigationController?.show(controller, sender: nil)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 320)
    }
}
