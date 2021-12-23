//
//  ViewController.swift
//  PhotoApp
//
//  Created by Aisha Al-Qarni on 21/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
    var array = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            guard let data = data else{return}
            do {
                let decoder = JSONDecoder()
                let decoderData =  try decoder.decode(DataModel.self, from: data)
                print(decoderData.title)
                decoderData.items.forEach { item in
                    print(item.media.m)
                    let newPhoto = item.media.m
                    self.array.append(self.getImage(from: newPhoto)!)
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }catch {
                print(error)
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.imageCell.image = array[indexPath.row]
        return cell
    }
    
    
    
}

