//
//  ViewController.swift
//  GetImageFromJson
//
//  Created by Ebtesam Alahmari on 21/12/2021.
//

import UIKit

class ViewController: UIViewController {
   
    var imgArr = [UIImage]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //------
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            guard let data = data else{return}
            do {
                let decoder = JSONDecoder()
                let decoderData =  try decoder.decode(DataModel.self, from: data)
                print("========")
                print(decoderData.title)
                
                decoderData.items.forEach { item in
                    print(item.media.m)
                    let newImage = item.media.m
                    self.imgArr.append(self.getImage(from: newImage)!)
                }
                
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
           
            }catch {
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.img.image = imgArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
}
