//
//  DetailInfoCell.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 27/07/22.
//

import Foundation
import UIKit

class DetailInfoCell: UITableViewCell {
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var sectionDetail: UILabel!
    
    var detailInfo: String?
    var releaseDate: String?
    var isOverview: Bool = false
    
    func bind(info: String, releaseDate: String, isOverview: Bool) {
        detailInfo = info
        self.releaseDate = releaseDate
        self.isOverview = isOverview
        
        setupSectionTitle()
        setupInfo()
    }
    
    func setupSectionTitle() {
        sectionTitle.text = isOverview ? "Overview" : "Release Data"
    }
    
    func setupInfo() {
        DispatchQueue.main.async { [self] in
            sectionDetail.text = isOverview ? detailInfo : releaseDate
            layoutIfNeeded()
        }
    }
}
