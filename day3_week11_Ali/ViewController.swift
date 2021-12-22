//
//  ViewController.swift
//  day3_week11_Ali
//
//  Created by AlDanah Aldohayan on 21/12/2021.
//

import UIKit
struct DataModel: Codable {
    var items: [Items]
}

struct Items: Codable {
    
    var media: Media
}

struct Media: Codable {
    var m: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewAPI: UITableView!
    var arrAPI: [UIImage] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewAPI.delegate = self
        tableViewAPI.dataSource = self
        woho()
        
    }
    func woho() {
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let decoderData = try decoder.decode(DataModel.self, from: data)
                print(decoderData.items)
                DispatchQueue.main.async {
                    decoderData.items.forEach { item in
                        let img = item.media.m
                        let image = self.getImage(from: img)

                        self.arrAPI.append(image!)
                        print(self.arrAPI.count)
                    }
                    self.tableViewAPI.reloadData()
                }
                
            } catch {
                print(error.localizedDescription)
            }

        }.resume()
        
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

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.img.image = arrAPI[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
}


