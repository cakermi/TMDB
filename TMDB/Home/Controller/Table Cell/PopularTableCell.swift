//
//  PopularTableCell.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation
import UIKit

class PopularTableCell: UITableViewCell {
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeTitle: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var popularMovie: HomePopularMovieViewModel?
    var popularDelegate: PopularDelegate?
    
    func bind(popularMovie: HomePopularMovieViewModel?, delegate: PopularDelegate?) {
        self.popularMovie = popularMovie
        self.popularDelegate = delegate
        
        getPopularMovie()
    }
    
    func getPopularMovie() {
        loadingIndicator.startAnimating()
        HomeService.shared.getMainMoview(token: RestClient.API_KEY, completion: getPopularMovieHandler(response:error:))
    }
    
    func getPopularMovieHandler(response: MovieListResponse?, error: Error?) {
        guard error == nil else {
            print("error getPopular \(error.debugDescription)")
            return
        }
        
        popularMovie = HomePopularMovieViewModel(response: response!)
        popularDelegate?.updatePopularVM(update: popularMovie!)
        setupPopularUI()
    }
    
    func setupPopularUI() {
        let DEFAULT_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
        let POPULAR_URL  = "\(DEFAULT_IMAGE_URL)\(popularMovie?.movie?.posterPath ?? "")"
        DispatchQueue.main.async { [self] in
            homeImage.load(url: URL(string: POPULAR_URL)!)
            homeImage.contentMode = .scaleAspectFill
            
            homeTitle.text = popularMovie?.movie?.title ?? "-"
            homeTitle.isHidden = false
            
            loadingIndicator.stopAnimating()
        }
    }
}

protocol PopularDelegate {
    func updatePopularVM(update: HomePopularMovieViewModel)
}
