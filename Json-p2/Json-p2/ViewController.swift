//
//  ViewController.swift
//  Json-p2
//
//  Created by Badreah Saad on 21/12/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTabel: UITableView!
    
    var myArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTabel.delegate = self
        myTabel.dataSource = self
//        myTabel.estimatedRowHeight = 100
//        myTabel.rowHeight = UITableView.automaticDimension
        downloadImage()
    }
    
    
    func downloadImage() {
        let url = URL (string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let task = URLSession.shared.dataTask(with: url!) { data, respons, error in
            guard let data = data else { return }
            do {
                let decodedData =  try JSONDecoder().decode(DataModel.self, from: data)
//                print(decodedData.link)
                
                for item in decodedData.items {
                    let images = item.media.m
                    print(images)
                    self.myArray.append(images)
                }
                
            } catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                print(self.myArray.count)
                self.myTabel.reloadData()
            }
        }
        task.resume()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTabel.dequeueReusableCell(withIdentifier: "cell") as! TabelCell
                
        if let url = URL(string: myArray[indexPath.row]) {
            if let data = try? Data(contentsOf: url) {
                cell.myImage.image = UIImage(data: data)
            }
        }
        return cell
        
    }
    
    
    
    
    
}


struct DataModel: Codable {
    var title: String
    var items: [Items]
}

struct Items: Codable {
    var title: String
    var media: Media
}

struct Media: Codable {
    var m: String
}



