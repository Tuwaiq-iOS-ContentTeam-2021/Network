//
//  imageViewCell.swift
//  TableViewJson
//
//  Created by esho on 17/05/1443 AH.
//

import UIKit

class imageViewCell: UITableViewCell {
    
    @IBOutlet weak var imagecell: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
