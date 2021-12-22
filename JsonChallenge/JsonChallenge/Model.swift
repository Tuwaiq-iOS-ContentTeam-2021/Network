//
//  Model.swift
//  JsonChallenge
//
//  Created by Rayan Taj on 21/12/2021.
//

import Foundation
struct ImageStruct: Codable {
    let title: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let media: Media
}

// MARK: - Media
struct Media: Codable {
    let m: String
}
