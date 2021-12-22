//
//  ImageTableViewCell.swift
//  JsonChallenge
//
//  Created by Rayan Taj on 21/12/2021.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet var imageViewData: UIImageView!
    @IBOutlet var email: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
