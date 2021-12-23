//
//  ViewController.swift
//  Network1
//
//  Created by Mola on 21/12/2021.
//

import UIKit

class ViewController: UIViewController{
    
    var imageList: [UIImage] = []
    var titleList: [String] = []

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            guard let data = data else{
                return
            }
            do{
                let decodeData = try JSONDecoder().decode(DataModel.self, from: data)
                
                DispatchQueue.main.async {
                    decodeData.items.forEach{ item in
                        let url = URL(string: item.media.m)
                        let data = try? Data(contentsOf: url!)
                        self.imageList.append(UIImage(data: data!)!)
                        self.titleList.append(item.title)
                        
                        print(item.media.m)
                        print(item.title)
                    }
                    self.myCollectionView.reloadData()
                }
                
            } catch {
                print("Error: ",error.localizedDescription)
            }
        }
        task.resume()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCell
        cell.myImage.image = imageList[indexPath.row]
        cell.myTitle.text = titleList[indexPath.row]

        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.0, height: 200.0)
    }
}
