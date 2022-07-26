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
    
    func bind(popularMovie: HomePopularMovieViewModel?) {
        self.popularMovie = popularMovie
        
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
        setupPopularUI()
    }
    
    func setupPopularUI() {
        let DEFAULT_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
        let POPULAR_URL  = "\(DEFAULT_IMAGE_URL)\(popularMovie?.posterPath ?? "")"
        DispatchQueue.main.async { [self] in
            homeImage.load(url: URL(string: POPULAR_URL)!)
            homeImage.contentMode = .scaleAspectFill
            
            homeTitle.text = popularMovie?.title ?? "-"
            homeTitle.isHidden = false
            
            loadingIndicator.stopAnimating()
        }
    }
}
