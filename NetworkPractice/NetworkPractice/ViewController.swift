//
//  ViewController.swift
//  NetworkPractice
//
//  Created by Ahmad MacBook on 21/12/2021.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var arr : [UIImage] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#"
        
        let urlObeject = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObeject!) { data, response, error in
            
            if let data = data {
                do {
                    
                    if let decodedResponse = try? JSONDecoder().decode(DataModel.self, from: data) {
                        
                        
                        DispatchQueue.main.async {
                            
                            decodedResponse.items.forEach { item in
                                print(item.media.m)
                                
                                
                                let data = try? Data(contentsOf: URL(string: item.media.m )!)
                                self.arr.append(UIImage(data: data!)!)
                                
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()

                        }
                        
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
        
    }
    
    
}
extension ViewController : UITableViewDataSource , UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: [indexPath.row]) as! TableViewCell
        
        cell.imageFromJson.image = arr[indexPath.row]
        
        return cell
    }
    
}


