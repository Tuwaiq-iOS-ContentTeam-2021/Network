//
//  ViewController.swift
//  NetWORKS
//
//  Created by Um Talal 2030 on 21/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var myimgArr = [UIImage]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
      
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            guard let data = data else{return}
            do {
                let decoder = JSONDecoder()
                let decoderData =  try decoder.decode(DataModel.self, from: data)
                print(decoderData.title)
                
                decoderData.items.forEach { item in
                    print(item.media.m)
                    let newImage = item.media.m
                    self.myimgArr.append(self.getImage(from: newImage)!)
                }
                
                DispatchQueue.main.async{
                    self.myTableView.reloadData()
                }
           
            }catch {
                print(error)
            }
        }
        task.resume()
    }
    func getImage(from string: String) -> UIImage? {
          
            guard let url = URL(string: string)
                else {
                    print("Not found")
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myimgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.iimg.image = myimgArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        240
    }
}

      
