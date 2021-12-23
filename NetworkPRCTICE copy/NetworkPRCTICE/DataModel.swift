//
//  DataModel.swift
//  NetworkPRCTICE
//
//  Created by TAGHREED on 17/05/1443 AH.
//

import Foundation

struct DataModel: Codable {
    
    var items : [Items]
}

struct Items: Codable {
    
    var media : M
}

struct M: Codable{
    
    var m : String
}

