//
//  ViewController.swift
//  m_MusicIQ
//
//  Created by Craig Markowitz on 12/25/19.
//  Copyright © 2019 Craig Markowitz. All rights reserved.
//
// Download all songs from AWS: aws2 s3 cp s3://music-iq.audio /Users/craigmarkowitz/Documents/Development/m_Music_IQ/m_MusicIQ/Audio --recursive

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
            let full_question_list = self.readJsonFile()
            print(full_question_list)
        }
    }
    
    func readJsonFile() -> FullResponse{
        var questions:FullResponse? = nil

        if let path = Bundle.main.path(forResource: fileName, ofType: "json"){
            do{
                let decoder = JSONDecoder()
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                questions = try decoder.decode(FullResponse.self, from: data)
               
                print(questions)
            } catch{
                print("error: \(error)")
            }
         
        }
     return questions!
    }


}

