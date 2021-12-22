//
//  ViewController.swift
//  JSONtest
//
//  Created by Sahab Alharbi on 17/05/1443 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.imageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TaTableViewCell

        cell.imagee.image = imageData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 340
         }
    
    
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")

    
   
    var imageData : [UIImage] = []
  
    @IBOutlet weak var imageTV: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        imageTV.dataSource = self
        imageTV.delegate = self
        getData()

    }
    func getData() {
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let decoderData = try decoder.decode(DataModel.self, from: data)
                print(decoderData.items)
                decoderData.items.forEach { item in
                    let imge = item.media.m
                    let image = self.getImage(from: imge)
                    self.imageData.append(image!)
                }
                DispatchQueue.main.async {
                    
                    self.imageTV.reloadData()
                }

            } catch {
                print(error.localizedDescription)
            }

        }.resume()

    }

    func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string)
            else {
                print("Something Wrong")
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
