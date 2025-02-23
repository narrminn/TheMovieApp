import UIKit

protocol MovieCellProtocol {
    var titleText: String { get }
    var imageURL: String { get }
}

class ImageLabelCell: UICollectionViewCell {
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.textAlignment = .center
//        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureConstraints() {
        addSubview(titleLabel)  //foeach
        addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8)
        ])
    }
    
    func configure(data: MovieCellProtocol) {
        titleLabel.text = data.titleText
        movieImage.loadImage(url: data.imageURL)
    }
}
