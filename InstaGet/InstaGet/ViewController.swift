//
//  ViewController.swift
//  InstaGet
//
//  Created by Abdullah Alnutayfi on 21/12/2021.
//

import UIKit

class ViewController: UIViewController {
var viewModel = ViewModel()
    var images : [String] = []
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchImages { images in
            print("my data1",images)
            self.images = images
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        
    }
}
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell") as! MyTableViewCell
            cell.imgV.image = UIImage(data: self.viewModel.loadImage(ImageUrl: images[indexPath.row])!)
        return cell
    }
    
    
}

