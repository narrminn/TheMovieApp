import UIKit

class DetailCell: UICollectionViewCell {
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var similarMovies: [SimilarMovieResult] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureConstraints() {
        addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: topAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    fileprivate func configureUI() {
        collection.dataSource = self
        collection.delegate = self
        
        collection.register(ImageLabelCell.self, forCellWithReuseIdentifier: "ImageLabelCell")
    }
    
    func configure(similarMovies: [SimilarMovieResult]) {
        self.similarMovies = similarMovies
    }
}

extension DetailCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLabelCell", for: indexPath) as! ImageLabelCell
        
        cell.configure(data: similarMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: collectionView.frame.height)
    }
}
