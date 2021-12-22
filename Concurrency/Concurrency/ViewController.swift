//
//  ViewController.swift
//  Concurrency
//
//  Created by Ahmad MacBook on 21/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let serialQueue = DispatchQueue(label: "queuename")
        let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)

        serialQueue.async {
            for i in 1..<5 {
                print(i)
            }
        }

        concurrentQueue.async{
            for i in 5...10 {
                print(i)
            }
        }
        
    }

    @IBAction func buttonAction(_ sender: Any) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            
            for _ in 0...9999999 {
                
            }
        }
    }
    
    
}

