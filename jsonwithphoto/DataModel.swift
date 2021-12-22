//
//  DataModel.swift
//  jsonwithphoto
//
//  Created by loujain on 21/12/2021.
//

import UIKit

struct DataModel: Codable {
    var  items: [Items]
}

struct Items : Codable {
    var media : Media
    
}

struct Media : Codable {
    var m : String
}
