//
//  ViewController.swift
//  FlickerApp
//
//  Created by Lola M on 12/21/21.
//

import UIKit


class ViewController: UIViewController {
    var imagesUrls: [String] = []
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
//        myTableView.backgroundColor = .lightGray
        self.myTableView.rowHeight = myTableView.frame.width
        
        setup()
    }


    func setup() {

        let session = URLSession.shared
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let task = session.dataTask(with: url!) { data, response, error in
            guard let jsonData = data else { return }
            
        do {
            let decoder = JSONDecoder()
            let decoderData =  try decoder.decode(MyModel.self, from: jsonData)
            print(decoderData.title)
            
            self.imagesUrls.removeAll()
            
            decoderData.items.forEach { item in
                let newImage = item.media.m
                
                self.imagesUrls.append(newImage)
            }
            
            DispatchQueue.main.async{
                self.myTableView.reloadData()
            }
       
        } catch {
            print(error)
    }
        }
        task.resume()
        }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell") as! MyTableViewCell
        let thisItem = self.imagesUrls[indexPath.row]
        let url = URL(string: thisItem)!

        do {
            let data = try Data(contentsOf: url)
            cell.imageView!.image = UIImage(data: data)
        } catch {
            print(error)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return myTableView.frame.width/2
    }
    

}
