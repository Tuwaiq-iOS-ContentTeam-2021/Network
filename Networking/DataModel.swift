//
//  DataModel.swift
//  Networking
//
//  Created by Nora on 17/05/1443 AH.
//

import Foundation
import UIKit


struct DataModel: Codable {
   let items : [Items]
}

struct Items: Codable {
    
   let media: Media
}

struct Media: Codable {
    
    let m : String
}
