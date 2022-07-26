//
//  TrendingMovieViewModel.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation

class MovieViewModel {
    var posterPath: String?
    
    init(movie: Result) {
        posterPath = movie.posterPath
    }
}
