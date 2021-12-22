//
//  TableViewCell.swift
//  jsonwithphoto
//
//  Created by loujain on 21/12/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imagee: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
