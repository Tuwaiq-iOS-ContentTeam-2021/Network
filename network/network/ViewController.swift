//
//  ViewController.swift
//  network
//
//  Created by Ghada Fahad on 17/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    
    var arrItem = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data,
            response, error in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode([DataModel].self, from: data)
                decodeData.forEach { dataString in
                    
                }
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                print(self.arrItem.count)
            }
            
        } .resume()



    }


}

