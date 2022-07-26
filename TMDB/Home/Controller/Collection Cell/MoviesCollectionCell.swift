//
//  MoviesCollectionCell.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation
import UIKit

class MoviesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    
    var posterPath: String?
    
    func bind(vm: TrendingMovieViewModel) {
        posterPath = vm.posterPath
        
        setupImage()
    }
    
    func setupImage() {
        let DEFAULT_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
        let POPULAR_URL  = "\(DEFAULT_IMAGE_URL)\(posterPath ?? "")"
        
        movieImage.load(url: URL(string: "\(POPULAR_URL)")!)
        movieImage.contentMode = .scaleAspectFill
    }
}
