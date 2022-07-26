//
//  TrendingTableCell.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation
import UIKit

class TrendingTableCell: UITableViewCell {
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    var movies: [MovieViewModel] = []
    var moviePosters: [UIImage] = []
    var moviesDelegate: MoviesDelegate?
    var isTrending = false
    
    func bind(delegate: MoviesDelegate) {
        self.isTrending = self.reuseIdentifier == "trendingCell"
        setupCollection()
        setupTitle()
        getMovies()
    }
    
    func setupTitle() {
        if isTrending {
            sectionTitle.text = "Trending"
        } else {
            sectionTitle.text = "Discover"
        }
    }
    
    func setupCollection() {
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
        moviesCollection.reloadData()
    }
    
    func getMovies() {
        if isTrending {
            HomeService.shared.getTrendingMovie(token: RestClient.API_KEY, completion: getMoviesHandler(response:error:))
        } else {
            HomeService.shared.getDiscoverMovie(token: RestClient.API_KEY, completion: getMoviesHandler(response:error:))
        }
    }
    
    func getMoviesHandler(response: MovieListResponse?, error: Error?) {
        guard error == nil else {
            print("error getTrendingMovies \(error.debugDescription)")
            return
        }
        
        updateMoviePosters(response: response!)
    }
    
    func generateNewMoviesVM(input: MovieListResponse?) -> [MovieViewModel] {
        let movies = input?.results
        var res: [MovieViewModel] = []
        
        if let movies = movies {
            for movie in movies {
                let vm = MovieViewModel(movie: movie)
                res.append(vm)
            }
        }
        
        return res
    }
    
    func updateMoviePosters(response: MovieListResponse) {
        let movies = response.results
        moviePosters.removeAll()
        
        for movie in movies {
            let DEFAULT_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
            let POPULAR_URL  = "\(DEFAULT_IMAGE_URL)\(movie.posterPath)"
            let URL = URL(string: POPULAR_URL)!
            
            if let data = try? Data(contentsOf: URL) {
                let image = UIImage(data: data)
                
                if let poster = image {
                    moviePosters.append(poster)
                }
            }
        }
        
        updateViewModel(input: response)
    }
    
    func updateViewModel(input: MovieListResponse?) {
        let updateVM = generateNewMoviesVM(input: input)
        
        if isTrending {
            moviesDelegate?.updateTrendingViewModel(update: updateVM)
        } else {
            moviesDelegate?.updateDiscoverViewModel(update: updateVM)
        }
        
        movies = updateVM
        
        moviesCollection.reloadData()
    }
}

extension TrendingTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = moviePosters[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCollectionCell
        cell.bind(image: image)
        return cell
    }
}

protocol MoviesDelegate {
    func updateTrendingViewModel(update: [MovieViewModel])
    
    func updateDiscoverViewModel(update: [MovieViewModel])
}
