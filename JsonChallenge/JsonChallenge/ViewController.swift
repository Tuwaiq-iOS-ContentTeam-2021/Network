//
//  ViewController.swift
//  JsonChallenge
//
//  Created by Rayan Taj on 21/12/2021.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    
    var imagesArray : [UIImage]  = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
        
        cell.imageViewData.image = imagesArray[indexPath.row]
        
//        cell.email.text =
        
        
        return cell
        
    }
    

    @IBOutlet var tableView: UITableView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
fetchData()

    }
    
    func fetchData()  {
        
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#"
        
        let  urlObeject = URL(string: urlString)

        let request = URLRequest(url: urlObeject!)
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            if let data = data {
                
                do {
                          if let decodedResponse = try? JSONDecoder().decode(ImageStruct.self, from: data) {


                              DispatchQueue.main.async {


                                  decodedResponse.items.forEach { Item in
                                      
                                      print(Item.media.m)
                                      
                                     let url = URL(string: Item.media.m )
                                      
                                      
                                      let data = try? Data(contentsOf: url!)
                                      self.imagesArray.append(UIImage(data: data!)!)
}
                                  
                                  self.tableView.reloadData()
                                  
                              }

                          }
                      } catch  {
                          print("ERROR : ",error.localizedDescription)
                      }
            
            
            
            
        }


        
    }.resume()
    
    
    
}

}
        
