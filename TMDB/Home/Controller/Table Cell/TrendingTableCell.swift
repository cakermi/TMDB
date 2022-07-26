//
//  TrendingTableCell.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation
import UIKit

class TrendingTableCell: UITableViewCell {
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    var movies: [TrendingMovieViewModel] = []
    var trendingDelegate: TrendingDelegate?
    
    func bind() {
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
        moviesCollection.reloadData()
        
        getTrendingMovies()
    }
    
    func getTrendingMovies() {
        HomeService.shared.getTrendingMovie(token: RestClient.API_KEY, completion: getTrendingMoviesHandler(response:error:))
    }
    
    func getTrendingMoviesHandler(response: MovieListResponse?, error: Error?) {
        guard error == nil else {
            print("error getTrendingMovies \(error.debugDescription)")
            return
        }
        
        updateViewModel(input: response)
    }
    
    func generateNewTrendingMoviesVM(input: MovieListResponse?) -> [TrendingMovieViewModel] {
        let movies = input?.results
        var res: [TrendingMovieViewModel] = []
        
        if let movies = movies {
            for movie in movies {
                let vm = TrendingMovieViewModel(movie: movie)
                res.append(vm)
            }
        }
        
        return res
    }
    
    func updateViewModel(input: MovieListResponse?) {
        let updateVM = generateNewTrendingMoviesVM(input: input)
        trendingDelegate?.updateTrendingViewModel(update: updateVM)
        movies = updateVM
        
        moviesCollection.reloadData()
    }
}

extension TrendingTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCollectionCell
        cell.bind(vm: movie)
        return cell
    }
}

protocol TrendingDelegate {
    func updateTrendingViewModel(update: [TrendingMovieViewModel])
}
