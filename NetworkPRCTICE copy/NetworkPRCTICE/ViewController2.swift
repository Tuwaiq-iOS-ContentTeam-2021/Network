//
//  ViewController2.swift
//  NetworkPRCTICE
//
//  Created by TAGHREED on 17/05/1443 AH.
//

import UIKit

class ViewController2: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var imgArr = [UIImage]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.imageView?.image = imgArr[indexPath.row]
        
        return cell
    }
    
    @IBOutlet weak var tv: UITableView!
    
    let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
    let session = URLSession.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task = session.dataTask(with: url!) { data , response, error in
            guard let data = data else {
                return
            }
            do{
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(DataModel.self, from: data )
                
                decodeData.items.forEach { item in
                    let  stringImg = item.media.m
                    print(stringImg)
                    self.imgArr.append(self.getImage(from: stringImg)!)
                }
                
            }catch{
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
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
