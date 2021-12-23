//
//  ViewController.swift
//  TableViewJson
//
//  Created by esho on 17/05/1443 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ImageArray = [UIImage]()

    @IBOutlet weak var TableView: UITableView!
    
    let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        getImage()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! imageViewCell
        cell.imgView?.image = ImageArray[indexPath.row]
        return cell
    }

    func getImage() {
        
        
        let Tasks = URLSession.shared.dataTask(with: url!) { data, response , error in

       
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(DataModel.self, from: data)
                
                decodeData.items.forEach { item in
                    let myimage = item.media.m
                    print(myimage)
                    let Uiimage = self.transImage(from: myimage)
                    self.ImageArray.append(Uiimage!)
                }

            }catch {
                print(error)
            }
        
        
    }
        Tasks.resume()
    }
       
        func transImage(from string: String) -> UIImage? {
               guard let url = URL(string: string)
               else {
                   print("error")
                   return nil
               }

               var images: UIImage? = nil
               do {
                   let data = try Data(contentsOf: url, options: [])

                   images = UIImage(data: data)
               }
               catch {
                   print(error.localizedDescription)
               }

               return images
           }
    
    
    
            
        



    
    
   
    

}

//my struct JSON
struct DataModel : Codable {
    var items : [Items]

}

struct Items : Codable {
    var media : Media
    
}
    struct Media : Codable {
        var m : String
     
    }
 


