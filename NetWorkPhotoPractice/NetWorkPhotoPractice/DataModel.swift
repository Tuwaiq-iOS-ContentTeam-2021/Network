

import Foundation

struct DataModel : Codable {
    var title : String
    var items : [Items]
}
struct Items : Codable {
    var media : Media
}
struct Media : Codable {
    var m : String
}
