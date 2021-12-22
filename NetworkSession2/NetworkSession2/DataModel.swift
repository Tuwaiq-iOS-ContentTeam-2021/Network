//
//  DataModel.swift
//  NetworkSession2
//
//  Created by mac on 21/12/2021.
//

import Foundation

struct DataModel: Codable {
    var items: [Item]
}


struct Item: Codable {
    var media: media
}

struct media: Codable {
    var m: String
}













//struct DataModel: Codable {
//    var name: String
//    var email: String
//    var address: Address
//}
//
//struct Address: Codable {
//    var street: String
//    var city: String
//    var geo: Geo
//}
//
//struct Geo: Codable {
//    var lat: String
//    var lng: String
//}
