//
//  DataModale.swift
//  NetworkeData
//
//  Created by Qahtani's MacBook Pro on 12/21/21.
//

import Foundation

struct DataModale : Codable {
    var title : String
    
    var items : [items]
    
}

struct items :Codable {
   
    var media : Media
    
    
}
struct Media: Codable {
    
    var m : String
    
    
}
