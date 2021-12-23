//
//  DataModel.swift
//  Pictures
//
//  Created by Mola on 21/12/2021.
//

import Foundation

struct DataModel: Codable{
    var items: [Items]
}

struct Items: Codable{
    var title: String
    var media: Media
}
struct Media: Codable{
    var m: String
}
