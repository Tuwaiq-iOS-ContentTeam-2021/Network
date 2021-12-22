//
//  ViewController.swift
//  HwNetworking
//
//  Created by Najla Talal on 12/22/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrImage = [details]()
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        fetchImage()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myCell
        cell.title.text = arrImage[indexPath.row].titel
        cell.myImage.image = arrImage[indexPath.row].image
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImage.count
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
        
    }
    
    
    func fetchImage() {
        
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data , respone, error in
            guard let data = data else {
                return
            }
            do {
                
                let decoder = JSONDecoder()
                let decoderData = try decoder.decode(DataModel.self, from:data)
                decoderData.items.forEach({ element in
                    let name = element.media.m
                    print(name)
                    let titel = element.title
                    let image = self.getImage(from: name)
                    self.arrImage.append(details(image: image! , titel: titel ))
                    
                    
                    
                    
                })
                
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
                
            } catch  {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    func getImage(from string: String) -> UIImage? {
        
        guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
        }
        
        var image: UIImage? = nil
        do {
            
            let data = try Data(contentsOf: url, options: [])
            
            
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return image
    }
    
    
    
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




