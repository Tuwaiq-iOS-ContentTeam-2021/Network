//
//  DataModel.swift
//  RequestImage
//
//  Created by Abdullah AlRashoudi on 12/21/21.
//

import Foundation

struct DataModel: Codable {
    var items: [Item]
    }

struct Item: Codable {
    var title: String
    var media: Media
}

struct Media: Codable {
    var m : String
}
