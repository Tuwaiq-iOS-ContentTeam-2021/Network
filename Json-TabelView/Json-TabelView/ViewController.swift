//
//  ViewController.swift
//  Json-TabelView
//
//  Created by Taraf Bin suhaim on 17/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
  
    var arrayOfImages = [UIImage]()
    
    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.dataSource = self
        tabelView.delegate = self
        
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            guard let data = data else {return}
            do{
                let decoder = JSONDecoder()
                let decoderData = try decoder.decode(img.self, from: data)
                print(decoderData.title)
                
                decoderData.items.forEach { item  in
                    print(item.media.m)
                    let a = item.media.m
                    self.arrayOfImages.append(self.getImage(from:a)!)
                    print(self.arrayOfImages)
                }
                
                DispatchQueue.main.sync {
                 self.tabelView.reloadData()
                }
            }
           catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }

        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])

            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }

        return image
    }
}

extension ViewController: UITableViewDataSource  , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.img.image = arrayOfImages[indexPath.row]
        return cell
    }
}


struct img : Codable {
    var title : String
    var items : [Item]
}

struct Item : Codable{
    var media : Media
}

struct Media : Codable {
   var  m : String
}
