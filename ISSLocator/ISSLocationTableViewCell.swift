//
//  ISSLocationTableViewCell.swift
//  ISSLocator
//
//  Created by Corey Zanotti on 10/17/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//

import UIKit

class ISSLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        yesButton.layer.borderColor = UIColor.white.cgColor
        noButton.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
