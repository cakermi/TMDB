//
//  DetailImageCell.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 27/07/22.
//

import Foundation
import UIKit

class DetailImageCell: UITableViewCell {
    @IBOutlet weak var detailImage: UIImageView!
    
    var image: UIImage?
    
    func bind(image: UIImage?) {
        if image != nil {
            self.image = image
            
            setupImage()
        }
    }
    
    func setupImage() {
        if let image = image {
            detailImage.image = image
            detailImage.contentMode = .scaleAspectFill
        }
    }
}
