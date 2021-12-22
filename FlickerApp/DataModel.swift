//
//  DataModel.swift
//  FlickerApp
//
//  Created by Lola M on 12/22/21.
//

import UIKit


struct MyDataModel: Codable {
    var title: String
    var link: String
    var items: [Items]
}

struct Items: Codable {
    var title: String
    var link: String
    var media: Media
}

struct Media: Codable {
    var m: String
}
