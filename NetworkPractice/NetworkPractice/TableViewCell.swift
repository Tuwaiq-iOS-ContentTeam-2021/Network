//
//  TableViewCell.swift
//  NetworkPractice
//
//  Created by Ahmad MacBook on 21/12/2021.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var imageFromJson: UIImageView!
    
    @IBOutlet weak var textTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }


}
