//
//  GetImage.swift
//  gitJasonImage
//
//  Created by Areej on 21/12/2021.
//

import Foundation


struct DataModel : Codable{
  
    var items : [ItemsModel]
}
struct ItemsModel: Codable {
    
    var media : Media
}

struct Media : Codable{
    var m : String
}
