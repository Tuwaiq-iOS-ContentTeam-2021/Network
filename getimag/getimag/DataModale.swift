//
//  DataModale.swift
//  getimag
//
//  Created by Abrahim MOHAMMED on 21/12/2021.
//

import Foundation


struct DataModale : Codable{
    
    var title : String
    
    var items : [items]
    
}

struct items :Codable {
   
    var media : Media
    
   // [String: String]()
    
}
struct Media: Codable {
    
    var m : String
    
    
}



