//
//  DataModel.swift
//  JSONtest
//
//  Created by Sahab Alharbi on 17/05/1443 AH.
//


import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    let title: String
//    let link: String
//    let dataModelDescription: String
//    let modified: Date
//    let generator: String
    let items: [Item]

//    enum CodingKeys: String, CodingKey {
//        case title
//        case dataModelDescription = "description"
//        case items
//    }
}

// MARK: - Item
struct Item: Codable {
    let title: String
//    let link: String
    let media: Media
//    let dateTaken: Date
//    let itemDescription: String
//    let published: Date
//    let author, authorID, tags: String

//    enum CodingKeys: String, CodingKey {
//        case title, media
//        case dateTaken = "date_taken"
//        case itemDescription = "description"
//        case published, author
//        case authorID = "author_id"
//        case tags
//    }
}

// MARK: - Media
struct Media: Codable {
    let m: String
}
