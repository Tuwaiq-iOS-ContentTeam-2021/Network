//
//  ViewController.swift
//  NetworkSession2
//
//  Created by mac on 21/12/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagesTableView: UITableView!
    var arrImages: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(DataModel.self, from: data)
             
           
                DispatchQueue.main.async {
                    decodeData.items.forEach({ Item in
                    print(Item.media.m)
                    let url = URL(string: Item.media.m )
                    let data = try? Data(contentsOf: url!)
                    self.arrImages.append(UIImage(data: data!)!)
                })
                    self.imagesTableView.reloadData()

                }
                
            }catch {
                print(error)
            }
        }
        task.resume()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = imagesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! imagesTableViewCell
        cell.myImage.image = arrImages[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }


}

