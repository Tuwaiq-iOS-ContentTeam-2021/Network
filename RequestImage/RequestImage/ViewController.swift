//
//  ViewController.swift
//  RequestImage
//
//  Created by Abdullah AlRashoudi on 12/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrayImage: [UIImage] = []
    var arrayTitle: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared
        
        session.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                

                return
            }
            do {
                let decoder = JSONDecoder()
                let decoderData = try decoder.decode(DataModel.self, from: data)
               try decoderData.items.forEach{ item in
                    
                    
                    let url = URL(string: item.media.m)
                    let imageData = try Data(contentsOf: url!)
                    let image = UIImage(data: imageData)!
                   self.arrayImage.append(image)
                   self.arrayTitle.append(item.title)
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
                   
                    
                }
            }catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayImage.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! ImageCell
        cell.imageCell.image = arrayImage[indexPath.row]
        cell.imageLabel.text = arrayTitle[indexPath.row]
        return cell
    }
    
    
    
    
}
