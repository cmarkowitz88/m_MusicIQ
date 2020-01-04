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
    let obj_common = Common(debug_mode: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.lblHello.text = "Hello to the world"
        
        // If we are not connected to the internet we can read the static JSON file, otherwise call AWS to get data
        if (self.obj_common.debug_mode == true){
            self.readJsonFile()
        }
    }
    
    func readJsonFile(){
        if let path = Bundle.main.path(forResource: fileName, ofType: "json"){
            do{
                let decoder = JSONDecoder()
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoded = try decoder.decode(FullResponse.self, from: data)
                print(decoded)
            } catch{
                print("error: \(error)")
            }
            
        }
    }


}

