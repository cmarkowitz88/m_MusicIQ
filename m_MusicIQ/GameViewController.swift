//
//  ViewController.swift
//  m_MusicIQ
//
//  Created by Craig Markowitz on 12/25/19.
//  Copyright © 2019 Craig Markowitz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var lblHello: UILabel!
    let fileName = "MusicIQ_All_Songs"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.lblHello.text = "Hello to the world"
        self.readJsonFile()
    }
    
    func readJsonFile(){
        if let path = Bundle.main.path(forResource: fileName, ofType: "json"){
            do{
                let decoder = JSONDecoder()
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let decoded = try decoder.decode(FullResponse.self, from: data)
                print(decoded)
               
                print(data)
            } catch{
                print("error: \(error)")
            }
            
        }
    }


}

