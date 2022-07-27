//
//  DetailViewController.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleNavigation: UINavigationItem!
    @IBOutlet weak var detailTable: UITableView!
    
    let DETAIL_ROW = ["imageCell", "overviewCell", "releaseCell"]
    
    var movie: Result?
    var detailImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupTitleNav()
        setupTable()
        downloadImage()
    }
    
    func setupTitleNav() {
        DispatchQueue.main.async { [self] in
            if let movie = movie {
                titleNavigation.title = movie.originalTitle
                //todo
            }
        }
    }
    
    func downloadImage() {
        let DEFAULT_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
        let POPULAR_URL  = "\(DEFAULT_IMAGE_URL)\(movie?.posterPath ?? "")"
        let URL = URL(string: POPULAR_URL)!
        
        if let data = try? Data(contentsOf: URL) {
            detailImage = UIImage(data: data)
            detailTable.reloadData()
        }
    }
    
    func setupTable() {
        detailTable.delegate = self
        detailTable.dataSource = self
        detailTable.estimatedRowHeight = 50
        detailTable.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DETAIL_ROW.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = DETAIL_ROW[indexPath.row]
        
        if id == "imageCell" {
            return getDetailImageCell(tableView: tableView, indexPath: indexPath)
        } else {
            return getDetailInfoCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func getDetailImageCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DETAIL_ROW[indexPath.row], for: indexPath) as! DetailImageCell
        cell.bind(image: detailImage)
        
        return cell
    }
    
    func getDetailInfoCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let isOverview = DETAIL_ROW[indexPath.row] == DETAIL_ROW[1]
        let cell = tableView.dequeueReusableCell(withIdentifier: DETAIL_ROW[1], for: indexPath) as! DetailInfoCell
        let info = movie?.overview ?? "Movie Overview"
        let date = movie?.releaseDate ?? "Release Date"
        
        cell.bind(info: info , releaseDate: date, isOverview: isOverview)
        
        return cell
    }
}
