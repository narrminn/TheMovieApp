//
//  SeeAllController.swift
//  TheMovieApp
//
//  Created by Narmin Alasova on 09.02.25.
//

import UIKit

class SeeAllController: UIViewController {
    
    private var viewModel = SeeAllViewModel()

    override func viewDidLoad() {
    }
    
    func configure(movies: [MovieResult]) {
        viewModel.movies = movies
    }
}
