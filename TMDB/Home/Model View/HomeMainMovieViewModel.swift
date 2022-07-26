//
//  HomeMainMovieViewModel.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation

class HomePopularMovieViewModel {
    var movie: Result?
    
    init(response: MovieListResponse) {
        self.movie = response.results[0]
    }
    
    
}
