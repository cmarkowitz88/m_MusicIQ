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
    
    // Properties
    @IBOutlet weak var lblQuestion: UILabel!
    
    let obj_common = Common(value: true)
    var full_question_list = FullResponse()
    var song_list = FullResponse.Song()
    var song_counter = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
                
        // If we are not connected to the internet we can read the static JSON file, otherwise call AWS to get data.
        if (self.obj_common.debug_mode == true){
            full_question_list = self.readJsonFile()
            print(full_question_list)
        }
       
        self.showQuestion(questions: full_question_list)
    }
    
    func showQuestion(questions: FullResponse){
        lblQuestion.text = "hello"
        lblQuestion.contentMode = .scaleToFill
        lblQuestion.numberOfLines = 0
        
        /* for question in questions.body{
            print(question)
        }
        print(questions) */
        
        lblQuestion.text = questions.body[0].Question as String
        self.createButtons(text: "hello")
          
    }
    
    func createButtons(text: String){
        
        var x: Int
        var y: Int
        var count = 0
        let numButtons = 4
        
        x = 30
        y = 250
        while count < numButtons{
          let button = UIButton()
          button.frame = CGRect(x:x,y:y, width:350, height:40)
            button.backgroundColor = UIColor.gray
          view.addSubview(button)
          y = y + 60
          count = count + 1
           
        }
    }
    
    func readJsonFile() -> FullResponse{
        var questions = FullResponse()

        if let path = Bundle.main.path(forResource: obj_common.file_name, ofType: "json"){
            do{
                let decoder = JSONDecoder()
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                questions = try decoder.decode(FullResponse.self, from: data)
               
                print(questions)
            } catch{
                print("error: \(error)")
            }
         
        }
        
     return questions
        
    }
}

