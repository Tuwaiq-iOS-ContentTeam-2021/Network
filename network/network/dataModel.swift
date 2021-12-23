//
//  dataModel.swift
//  network
//
//  Created by Ghada Fahad on 17/05/1443 AH.
//

import Foundation



        
        
struct DataModel: Codable {
            
    var items : Items
}

struct Items: Codable {
   var  link : String
  var   media : String
}



    
    



