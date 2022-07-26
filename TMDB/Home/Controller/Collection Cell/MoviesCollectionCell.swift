//
//  MoviesCollectionCell.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation
import UIKit

class MoviesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var image: UIImage?
    
    func bind(image: UIImage) {
        self.image = image
        
        setupImage()
    }
    
    func setupImage() {
        movieImage.image = image
        movieImage.contentMode = .scaleAspectFill
        movieImage.isHidden = false
        
        loadingIndicator.stopAnimating()
    }
}
