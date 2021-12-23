//
//  ViewController.swift
//  gitJasonImage
//
//  Created by Areej on 21/12/2021.
//

import UIKit
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var images = [Media]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ImageViewCell
        cell.img.contentMode = .scaleAspectFill
//        if let url = URL(string: images[indexPath.row].m){
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//                guard let data = data, error == nil else {return}
//                DispatchQueue.main.async {
//                    cell.img.image = UIImage(data: data)
//                }
//        }
//
//        task.resume()
//        }
        let defaultlink = "https://api.flickr.com"
        let completelink = defaultlink +  images[indexPath.row].m
        cell.img.downloaded(from: completelink)
        return cell
        }
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
       
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            do{
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(DataModel.self, from: data)
                print("img = \(decodeData.items)")
//                for i in decodeData.items{
//                    var urlImage = ImageViewCell()
//                    self.images.append(Media(m:urlImage.img.image!))
//                }
               
            }catch{
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
        task.resume()
        }
        
    }




