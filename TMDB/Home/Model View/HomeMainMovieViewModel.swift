//
//  HomeMainMovieViewModel.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation

class HomePopularMovieViewModel {
    var posterPath: String?
    var title: String?
    
    init(response: MovieListResponse) {
        let movie = response.results[0]
        
        posterPath = movie.posterPath
        title = movie.title
    }
    
    
}
