//
//  TLVC.swift
//  NetworkingPractice- Images
//
//  Created by WjdanMo on 21/12/2021.
//

import UIKit

class PicsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pics = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.dataSource = self
        getPics()
        
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
        }
        
    }
    
    func getPics (){
        
        if let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#"){
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error != nil { return }
                
                guard let data = data else { return }
                
                do {
                    
                    let decodedData = try JSONDecoder().decode(Pic.self, from: data)
                    
                    decodedData.items.forEach { item in
                        
                        let newPic = item.media.m
                        
                        do{
                            if let image = try UIImage(data: Data(contentsOf: URL(string: newPic)!)){
                            self.pics.append(image)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                        
                            }
                        }
                        
                        catch{
                            print(error)
                        }
                    }
                    
                }
                catch{
                    print(error)
                }
 
            }.resume()
        }
    }
}

extension PicsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! ImageCell
        
        cell.myPic.image = pics[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
    
}
