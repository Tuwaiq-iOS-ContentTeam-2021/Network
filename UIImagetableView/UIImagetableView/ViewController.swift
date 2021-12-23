//
//  ViewController.swift
//  UIImagetableView
//
//  Created by Wejdan Alkhaldi on 17/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var imgarr : [UIImage] = []
    
    @IBOutlet weak var tabeView: UITableView!
    
    let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabeView.delegate = self
        tabeView.dataSource = self
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(DataModel.self, from: data) //
                print(decodeData.items)
                DispatchQueue.main.async {
                    decodeData.items.forEach{ item in
                        let image = item.media.m
                        let getimage = self.getImage(from : image)
                        self.imgarr.append(getimage!)
                        
                    }
                    self.tabeView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }
        task.resume()
        
    }
    func getImage(from String : String) -> UIImage? {
        
        guard let url = URL(string: String)
        else {
            print("can't crate URL")
            return nil
            
        }
        var photo : UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            
            photo = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return photo
    }
    
}



extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgarr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabeView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myCell
        
        cell.myImage.image = imgarr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}


