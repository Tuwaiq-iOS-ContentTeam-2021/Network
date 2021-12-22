//
//  MyTableViewCell.swift
//  FlickerApp
//
//  Created by Lola M on 12/21/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
