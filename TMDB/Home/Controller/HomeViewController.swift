//
//  HomeViewController.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 25/07/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var segmentedSwitch: UISegmentedControl!
    @IBOutlet weak var homeTable: UITableView!
    
    let tableRow = ["popularCell", "trendingCell", "discoverCell"]
    
    var popularMovieViewModel: HomePopularMovieViewModel?
    var trendingMoviesViewModel: [MovieViewModel] = []
    var discoverMoviesViewModel: [MovieViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTable()
    }
    
    func setupTable() {
        homeTable.delegate = self
        homeTable.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isPopular = indexPath.row == 0
        let isTrending = indexPath.row == 1
        
        if isPopular {
            return getPopularCell(tableView: tableView, indexPath: indexPath)
        } else {
            return getTrendingCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func getTrendingCell(tableView: UITableView, indexPath: IndexPath) -> TrendingTableCell {
        let id = tableRow[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! TrendingTableCell
        cell.bind(delegate: self)
        
        return cell
    }
    
    func getPopularCell(tableView: UITableView, indexPath: IndexPath) -> PopularTableCell {
        let id = tableRow[0]
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! PopularTableCell
        cell.bind(popularMovie: popularMovieViewModel)
        
        return cell
    }
}

extension HomeViewController: MoviesDelegate {
    func updateDiscoverViewModel(update: [MovieViewModel]) {
        self.discoverMoviesViewModel = update
    }
    
    func updateTrendingViewModel(update: [MovieViewModel]) {
        self.trendingMoviesViewModel = update
    }
}
