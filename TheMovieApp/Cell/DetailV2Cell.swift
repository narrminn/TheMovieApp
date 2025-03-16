import UIKit

class DetailV2Cell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var imdb: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var genresData: UILabel!
    
    @IBOutlet weak var collection: UICollectionView!
    
    var similarMovies: [SimilarMovieResult] = []
    
    var detailCallBack: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
        configureCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI() {
        posterImage.layer.masksToBounds = true
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = 20
        
        layer.cornerRadius = 20
    }
    
    fileprivate func configureCollectionView() {
        collection.dataSource = self
        collection.delegate = self
        
        collection.register(ImageLabelCell.self, forCellWithReuseIdentifier: "ImageLabelCell")
    }
    
    func configure(movie: MovieDetail, similarMovies: [SimilarMovieResult]) {
        self.similarMovies = similarMovies
        self.collection.reloadData()
                
        title.text = movie.originalTitle
        about.text = movie.overview
        
        var genresString = ""
        
        movie.genres?.forEach { genre in
            genresString = genresString + (genre.name ?? "") + ", "
        }
        
        genresData.text = genresString
        
//        if let spokenLanguages = movie.spokenLanguages {
//            language.text = spokenLanguages[0].englishName ?? ""
//        }
        
        language.text = movie.spokenLanguages?.first?.englishName ?? ""
        imdb.text = String(format: "%.1f", movie.voteAverage ?? 0) + "/10"
        
        let hour = Int(movie.runtime ?? 0) / 60
        let minute = Int(movie.runtime ?? 0) % 60
        
        time.text = hour > 0 ? "\(hour) h \(minute) min" : "\(minute) min"
        
        if let posterPath = movie.posterPath {
            posterImage.loadImage(url: posterPath)
        }
    }
}

extension DetailV2Cell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLabelCell", for: indexPath) as! ImageLabelCell
        
        cell.configure(data: similarMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieId = similarMovies[indexPath.row].id {
            detailCallBack?(movieId)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 320)
    }
}
