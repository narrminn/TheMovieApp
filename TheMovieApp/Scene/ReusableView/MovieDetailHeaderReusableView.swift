import UIKit

class MovieDetailHeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var imdb: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configureUI() {
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        
        layer.cornerRadius = 20
    }
    
    func configure(movie: MovieDetail) {
        title.text = movie.originalTitle
        about.text = movie.overview
        
        var genresString = ""
        
        movie.genres?.forEach { genre in
            genresString = genresString + (genre.name ?? "") + ", "
        }
        
        genres.text = genresString
        
//        if let spokenLanguages = movie.spokenLanguages {
//            language.text = spokenLanguages[0].englishName ?? ""
//        }
        
        language.text = movie.spokenLanguages?.first?.englishName ?? ""
        imdb.text = String(format: "%.1f", movie.voteAverage ?? 0) + "/10"
        
        let hour = Int(movie.runtime ?? 0) / 60
        let minute = Int(movie.runtime ?? 0) % 60
        
        time.text = hour > 0 ? "\(hour) h \(minute) min" : "\(minute) min"
        
        if let posterPath = movie.posterPath {
            image.loadImage(url: posterPath)
        }
    }
}
