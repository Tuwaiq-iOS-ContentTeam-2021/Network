//
//  ImageViewCell.swift
//  gitJasonImage
//
//  Created by Areej on 21/12/2021.
//

import UIKit

class ImageViewCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(url : String){
        
        img.layer.cornerRadius = 10
    }

}
