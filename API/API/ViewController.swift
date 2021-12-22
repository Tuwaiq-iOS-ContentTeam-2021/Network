//
//  ViewController.swift
//  API
//
//  Created by nouf on 21/12/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var arrImage = [Show]()
  
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getimage()
   
        
    }
    func getimage() {
        
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        let session = URLSession.shared //نفتح جلسه اتصال
        let task = session.dataTask(with: url!) { data , respone, error in
            guard let data = data else {
                return
            }
            do {
                
                let decoder = JSONDecoder()
                             let decoderData = try decoder.decode(DataModel.self, from:data)
                decoderData.items.forEach({ element in
                    let name = element.media.m
                    print(name)
                    let titel = element.title
                    let image = self.getImage(from: name)
                    self.arrImage.append(Show(image: image! , titel: titel ))
                        
                 
//                    print(self.arrImage)
                
})

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
              
                
        } catch  {
                print(error.localizedDescription)
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

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.titel.text = arrImage[indexPath.row].titel
        cell.image.image = arrImage[indexPath.row].image
  
        return cell
    }

}

struct DataModel : Codable  {
    var  title : String
    var  items : [Item]
    
}

struct Item : Codable  {
    var  media : Media
    var title : String
}

struct Media :  Codable  {
    var m : String
}

struct Show {
    
    var image : UIImage
    var titel : String
}
