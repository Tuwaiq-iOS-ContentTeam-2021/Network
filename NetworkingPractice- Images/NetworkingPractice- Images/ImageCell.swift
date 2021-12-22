//
//  ImageCell.swift
//  NetworkingPractice- Images
//
//  Created by WjdanMo on 21/12/2021.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var myPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
