//
//  ViewController.swift
//  Networking
//
//  Created by Nora on 17/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var images = [UIImage]()
    let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
    
    let myTableView : UITableView = {
        let myTableView = UITableView()
        myTableView.register(TableViewCell.self,forCellReuseIdentifier: "cell")
        return myTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(myTableView)
        myTableView.delegate = self
        myTableView.dataSource = self
        
        bringPhotos()
    }
    
    
    
    func bringPhotos(){
        
        let task = URLSession.shared.dataTask(with: url!) { data, response , error in
            
            guard let data = data else {
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decoderData = try decoder.decode(DataModel.self, from: data)
                print(decoderData.items)
                DispatchQueue.main.async {
                    decoderData.items.forEach { item in
                        
                        let image = item.media.m
                        let imageUI = self.transImage(from: image)
                        
                        
                        self.images.append(imageUI!)
                    }
                    self.myTableView.reloadData()
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTableView.frame = view.bounds
    }
    
    
    func transImage(from string: String) -> UIImage? {
        guard let url = URL(string: string)
        else {
            print("error")
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

extension ViewController :  UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.myImage.image = images[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    
    
    
}
