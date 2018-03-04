//
//  ViewController.swift
//  prism
//
//  Created by Jonathan Huang on 3/3/18.
//  Copyright © 2018 Jonathan Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tapButton(_ sender: UIButton) {
        print("tapped button")
        var request = URLRequest(url: URL(string: "http://localhost:4000/api/events?category_id=46")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        print("made request: \(request)")
        
        session.dataTask(with: request, completionHandler: {(data, response, error) in
            if(error != nil) {
                print("error")
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                } catch let error as NSError {
                    print(error)
                }

            }
        }).resume()
    }
}

