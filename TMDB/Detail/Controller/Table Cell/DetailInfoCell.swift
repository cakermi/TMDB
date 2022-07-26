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
    
    func bind(info: String) {
        detailInfo = info
        
        setupInfo()
    }
    
    func setupInfo() {
        DispatchQueue.main.async { [self] in
            sectionDetail.text = detailInfo
            layoutIfNeeded()
        }
    }
}
