//
//  DataModel.swift
//  GetImageFromJson
//
//  Created by Ebtesam Alahmari on 21/12/2021.
//

import Foundation


struct DataModel : Codable {
    var title: String
    var items : [Item]
}
struct Item : Codable{
    var media:Media
}
struct Media : Codable {
    var m: String
}
