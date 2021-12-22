//
//  MyTableViewCell.swift
//  InstaGet
//
//  Created by Abdullah Alnutayfi on 21/12/2021.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var imgV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgV.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imgV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.widthAnchor.constraint(equalToConstant: 350).isActive = true
        imgV.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
