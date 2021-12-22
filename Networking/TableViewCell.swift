//
//  TableViewCell.swift
//  Networking
//
//  Created by Nora on 17/05/1443 AH.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
    super.layoutSubviews()
        
        myImage.frame = CGRect(x: 50, y: 70, width: 300, height: 300)

    }

    
    
    // i did organized all views in Closures

    
    
    let myImage : UIImageView = {
        let myImage = UIImageView()
//        myImage.image = UIImage(systemName: "heart")
        myImage.tintColor = .red
        return myImage
    }()
    
}



