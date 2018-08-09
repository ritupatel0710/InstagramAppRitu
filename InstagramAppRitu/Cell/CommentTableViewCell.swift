//
//  CommentTableViewCell.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/8/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePhoto: UIImageView!
    
    @IBOutlet weak var commentLbl: UILabel!
    
    @IBOutlet weak var fullname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
