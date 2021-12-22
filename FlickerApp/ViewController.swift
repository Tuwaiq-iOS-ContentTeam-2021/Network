//
//  ViewController.swift
//  FlickerApp
//
//  Created by Lola M on 12/21/21.
//

import UIKit

typealias customType = (title: String, image: String, date_taken: String )

class ViewController: UIViewController {
    //..
    var arrOfMedia = [Media]()
    //..
    var imagesUrls: [String] = []
    var myModelArray: [customType] = []
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = .red
        
        setup()
    }


    func setup() {

        let session = URLSession.shared
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let task = session.dataTask(with: url!) { data, response, error in
            guard let jsonData = data else { return }
            
        do {
            let decoder = JSONDecoder()
            let decoderData =  try decoder.decode(myModelArray.self, from: jsonData)
            print(decoderData.title)
            
            self.myModelArray.removeAll()
            decoderData.items.forEach { item in
                let title = item.title
                let date_taken = item.date_taken
                let newImage = item.media.m
                
                let thisModel: customType = (title: title, image: newImage, date_taken: date_taken)
                self.myModelArray.append(thisModel)
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
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell") as! MyTableViewCell
        let thisItem = self.myModelArray[indexPath.row]
        let url = URL(string: thisItem.image)!

        do {
            let data = try Data(contentsOf: url)
            cell.imageView!.image = UIImage(data: data)
        } catch {
            print(error)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
    

}
