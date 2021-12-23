//
//  DataModel.swift
//  NetWORKS
//
//  Created by Um Talal 2030 on 21/12/2021.
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

