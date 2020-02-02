//
//  ViewController.swift
//  NetworkSample
//
//  Created by Raphael Henrique on 30/01/20.
//  Copyright © 2020 TBD-patrichel. All rights reserved.
//

import UIKit
import NetworkLIB

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        RequestLib.client.request(url: "https://jsonplaceholder.typicode.com/todos/1") { (data, response, error) in
            
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            print("gotten json response dictionary is \n \(json)")
            // update UI using the response here
            
        }
        
    }


}

