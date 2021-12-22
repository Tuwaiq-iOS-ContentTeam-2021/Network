//
//  ViewController2.swift
//  FlickerApp
//
//  Created by Lola M on 12/21/21.
//
//
import UIKit

class ViewController2: UIViewController {

    var arrOfMedia = [Media]()

    @IBOutlet weak var myImageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        let myImage = imageFromUrl(urlString: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#")
        
    }


    func setup() {

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let url = NSURL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#"){

            let task = session.dataTask(with: url as URL, completionHandler: {data, response, error in

                if let err = error {
                    print("Error: \(err)")
                    return
                }

                if let http = response as? HTTPURLResponse {
                    if http.statusCode == 200 {
                        let downloadedImage = UIImage(data: data!)
                        DispatchQueue.main.async {
                            self.myImageView2.image = downloadedImage
                        }
                    }
                }
           })
           task.resume()
        }
    }
    
    func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.myImageView2.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
    

    struct MyDataModel: Codable {
        var title: String
        var link: String
        var items: [Items]
    }
    struct Items: Codable {
        var title: String
        var link: String
        var media: Media
    }
    struct Media: Codable {
        var m: String
    }

}

