//
//  ListCell.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var posterName: UILabel!
    @IBOutlet var posterDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
