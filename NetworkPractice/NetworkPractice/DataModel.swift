//
//  dataModel.swift
//  NetworkPractice
//
//  Created by Ahmad MacBook on 21/12/2021.
//

import Foundation


struct DataModel : Codable{
    
    var items : [item]
}

struct item : Codable{
    
    var title : String
    var media : media
    
}

struct media : Codable{
    var m : String
    
}
