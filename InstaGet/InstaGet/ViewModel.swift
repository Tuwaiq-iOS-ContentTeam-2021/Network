//
//  ViewModel.swift
//  InstaGet
//
//  Created by Abdullah Alnutayfi on 21/12/2021.
//

import Foundation
import UIKit

class ViewModel {
   var images : [String] = []
    
    func fetchImages(completion : @escaping([String]) -> Void){
        let API_URL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=flower&nojsoncallback=1#"

          guard let url = URL(string: API_URL)else{
              print("Invalid URL . . . ")
              return
          }
          let request = URLRequest(url: url)
          let decoder = JSONDecoder()
          let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
              if let data = data{
                  do{
                      let response = try decoder.decode(MyData.self, from: data)
                      DispatchQueue.global(qos: .userInitiated).async{
                          response.items.forEach{
                              self.images.append($0.media.m)
                          }
                          completion(self.images)
                      }
                  }catch{
                      print(error)
                  }
              }
              print(error as Any)
          }
          dataTask.resume()
      }
    
    func loadImage(ImageUrl: String) -> Data?{
            guard let url = URL(string: ImageUrl) else {return Data()}
            if let data = try? Data(contentsOf: url){
                return data
            }
            return nil
        }
}


struct MyData: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [Item]
}
 
struct Item: Codable {
    let title: String
    let link: String
    let media: Media
    let date_taken: String
    let description: String
    let published: String
    let author, author_id, tags: String

}

struct Media: Codable {
    let m: String
}

