import UIKit

class MovieDetailHeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var imdb: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    
    private var lastSelectedSegmentIndex: Int = 0
    var segmentChangedAction: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
        setupSegment()
    }
    
    func configureUI() {
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        
        layer.cornerRadius = 20
    }
    
    func configure(movie: MovieDetail) {
        title.text = movie.originalTitle
        
//        if let spokenLanguages = movie.spokenLanguages {
//            language.text = spokenLanguages[0].englishName ?? ""
//        }
        
        language.text = movie.spokenLanguages?.first?.englishName ?? ""
        imdb.text = String(format: "%.1f", movie.voteAverage ?? 0) + "/10"
        
        var hour = Int(movie.runtime ?? 0) / 60
        var minute = Int(movie.runtime ?? 0) % 60
        
        time.text = hour > 0 ? "\(hour) h \(minute) min" : "\(minute) min"
        
        if let posterPath = movie.posterPath {
            image.loadImage(url: posterPath)
        }
    }
    
    func setupSegment() {
        guard let segment = segment else { return }
        
        segment.removeAllSegments()
        
        for detailSegment in DetailSegment.allCases {
            segment.insertSegment(withTitle: detailSegment.rawValue, at: segment.numberOfSegments, animated: false)
        }
        
        segment.selectedSegmentIndex = lastSelectedSegmentIndex
        segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        lastSelectedSegmentIndex = segment.selectedSegmentIndex
        
        segmentChangedAction?(lastSelectedSegmentIndex)
    }
    
}
