//
//  Structs.swift
//  HwNetworking
//
//  Created by Najla Talal on 12/22/21.
//

import UIKit

class Structs: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    struct DataModel : Codable  {
        var  title : String
        var  items : [Item]
        
    }

    struct details {
        
        var image : UIImage
        var titel : String
    }
    struct Item : Codable  {
        var  media : Media
        var title : String
    }


    struct Media :  Codable  {
        var m : String
    }



}
