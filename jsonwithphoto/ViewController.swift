//
//  ViewController.swift
//  jsonwithphoto
//
//  Created by loujain on 21/12/2021.
//

import UIKit

class ViewController: UIViewController{
    var arr :[UIImage] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, errorr in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let decoderData = try decoder.decode(DataModel.self, from: data)
                print(decoderData.items)
                DispatchQueue.main.async {
                    decoderData.items.forEach { item in
                        let image = item.media.m
                        let image1 = self.getImage(from: image)
                        
                        self.arr.append(image1!)
                        
                    }
                    self.tableView.reloadData()
                }
                
            } catch {
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
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.imagee.image = arr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    
}

