//
//  HomeServiceProtocol.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation

protocol HomeServiceProtocol {
    func getMainMoview(token: String, completion: @escaping(MovieListResponse?, Error?) -> Void)
    
    func getTrendingMovie(token: String, completion: @escaping(MovieListResponse?, Error?) -> Void)
    
    func getDiscoverMovie(token: String, completion: @escaping(MovieListResponse?, Error?) -> Void)
}
