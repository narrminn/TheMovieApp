import UIKit

class MovieDetailV2Controller: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    private var viewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    func configureUI() {
        table.dataSource = self
        table.delegate = self
        
        table.register(UINib(nibName: "\(DetailV2Cell.self)", bundle: nil), forCellReuseIdentifier: "\(DetailV2Cell.self)")
    }
    
    func configure(id: Int) {
        viewModel.movieId = id
        viewModel.getMovieDetail()
        viewModel.getMovieSimilar()
    }
    
    fileprivate func configureViewModel() {
        navigationItem.title = "Movie Details"
        
        viewModel.success = {
            self.table.reloadData()
        }
        
        viewModel.errorHandling = { error in
            print(error)
        }
    }
}

extension MovieDetailV2Controller: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailV2Cell.self)", for: indexPath) as! DetailV2Cell
        
        if let movie = viewModel.movie {
            cell.configure(movie: movie, similarMovies: viewModel.similarMovies)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        UITableView.automaticDimension
        return 1100
    }
}
