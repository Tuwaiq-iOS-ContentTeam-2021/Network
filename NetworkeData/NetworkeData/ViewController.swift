//
//  ViewController.swift
//  NetworkeData
//
//  Created by Qahtani's MacBook Pro on 12/21/21.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrImag: [UIImage] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImag.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = myTabelView.dequeueReusableCell(withIdentifier: "cell-id", for: indexPath) as!TVCell
        
        cell.myimage.image = arrImag[indexPath.row]
        
        return cell
    }
    
    
  
    
    @IBOutlet weak var myTabelView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTabelView.delegate = self
        myTabelView.dataSource = self
        
        
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
                            self.arrImag.append(UIImage(data: data!)!)

                            })
                            self.myTabelView.reloadData()
                        }

                    }catch {
                        print(error.localizedDescription)
                    }
                }
                task.resume()
        
        
    }


}

