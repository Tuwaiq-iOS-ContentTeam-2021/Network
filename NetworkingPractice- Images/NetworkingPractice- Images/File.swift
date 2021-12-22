//
//  File.swift
//  NetworkingPractice- Images
//
//  Created by WjdanMo on 21/12/2021.
//

import Foundation


struct Pic: Codable {
 
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
