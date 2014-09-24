//
//  YelpTableViewCell.swift
//  Yelp
//
//  Created by Kumar, Chandaraprakash on 9/21/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class YelpTableViewCell: UITableViewCell {


    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var listDistanceLabel: UILabel!
    @IBOutlet weak var listAddressLabel: UILabel!
    @IBOutlet weak var listCategoryLabel: UILabel!
    @IBOutlet weak var listRatingsImageView: UIImageView!
    @IBOutlet weak var listReviewLabel: UILabel!
    @IBOutlet weak var listDollarLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
