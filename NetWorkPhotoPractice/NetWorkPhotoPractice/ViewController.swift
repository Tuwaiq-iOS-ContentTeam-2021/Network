

import UIKit

class ViewController: UIViewController {
    let cache = NSCache<NSNumber, UIImage> ()
    let queue = DispatchQueue.global(qos: .utility)
    var imagesArray : [UIImage]  = []
    var descArray : [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
    
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
                    if let decodedResponse = try? JSONDecoder().decode(DataModel.self, from: data) {
                        
                        
                        DispatchQueue.main.async {
                            
                            self.descArray.append(decodedResponse.title)
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


extension ViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! MyTableViewCell
        cell.mImage.image = imagesArray[indexPath.row]
//        cell.mLabel.text = descArray[indexPath.row]
        return cell
    }
    
}
