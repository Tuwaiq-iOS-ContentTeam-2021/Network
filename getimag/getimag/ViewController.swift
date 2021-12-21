//
//  ViewController.swift
//  getimag
//
//  Created by Abrahim MOHAMMED on 21/12/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrimag: [UIImage] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrimag.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! imagTableViewCell
        cell.imageCell.image = arrimag[indexPath.row]
        
        return cell
        
        
    }
    

    @IBOutlet weak var MyTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyTableView.delegate = self
        MyTableView.dataSource = self
        
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
                
        let session = URLSession.shared
                let task = session.dataTask(with: url!) { data, response, error in
                    guard let data = data else {
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let decodeData = try decoder.decode(DataModale.self, from: data)

                        
                        
                        
                        print(decodeData.items)
                        
                        DispatchQueue.main.async {
                            decodeData.items.forEach({ Item in
                                let url = URL(string: Item.media.m )
                                let data = try? Data(contentsOf: url!)
                            self.arrimag.append(UIImage(data: data!)!)

                            })
                            self.MyTableView.reloadData()
                        }

                    }catch {
                        print(error.localizedDescription)
                    }
                }
                task.resume()
        
        
    }


}

