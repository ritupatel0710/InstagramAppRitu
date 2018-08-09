//
//  HomeTableViewCell.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/4/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfilePhoto: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postPhoto: UIImageView!
    
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var commentClick: UIButton!
    
    @IBOutlet weak var likeClick: UIButton!
    
    @IBOutlet weak var noofLikesClick: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        likeClick.setImage(UIImage(named: "like"), for: .normal)
        likeClick.setImage(UIImage(named: "likeFilled"), for: .selected)
        likeClick.isSelected = UserDefaults.standard.bool(forKey: "isSaved")
        // Configure the view for the selected state
    }

}
