//
//  MyModel.swift
//  tableviewTest
//
//  Created by Haseeb Javed on 22/12/2021.
//


import Foundation


struct MyModel : Codable {
    var title: String
    var items : [Item]
}
struct Item : Codable{
    var media:Media
}
struct Media : Codable {
    var m: String
}


