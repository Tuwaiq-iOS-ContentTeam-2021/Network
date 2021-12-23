//
//  DataModel.swift
//  UIImagetableView
//
//  Created by Wejdan Alkhaldi on 17/05/1443 AH.
//

import Foundation
import UIKit
struct DataModel : Codable {
    var items : [Items]
}
struct Items : Codable {
    var media : Media
}

struct Media : Codable {
    var m : String
}
