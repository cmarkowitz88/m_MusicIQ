//
//  ViewController.swift
//  m_MusicIQ
//
//  Created by Craig Markowitz on 12/25/19.
//  Copyright © 2019 Craig Markowitz. All rights reserved.
//
// Download all songs from AWS: aws2 s3 cp s3://music-iq.audio /Users/craigmarkowitz/Documents/Development/m_Music_IQ/m_MusicIQ/Audio --recursive

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    // Properties
    @IBOutlet weak var lblQuestion: UILabel!
    
    let obj_common = Common(value: true)
    var full_question_list = FullResponse()
    var song_list = FullResponse.Song()
    var song_counter = 0
    var avPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
                
        // If we are not connected to the internet we can read the static JSON file, otherwise call AWS to get data.
        if (self.obj_common.offline_mode == true){
            full_question_list = self.readJsonFile()
            print(full_question_list)
        }
        else{
            // Get question list from AWS
        }
       
        self.showQuestion(questions: full_question_list)
    }
    
    func showQuestion(questions: FullResponse){
        lblQuestion.text = "hello"
        lblQuestion.contentMode = .scaleToFill
        lblQuestion.numberOfLines = 0
        let answerAry:[String] = [questions.body[0].Answer1, questions.body[0].Answer2, questions.body[0].Answer3,                                questions.body[0].Answer4]
        
        /* for question in questions.body{
            print(question)
        }
        print(questions) */
        
        lblQuestion.text = questions.body[0].Question as String
        self.createButtons(answers: answerAry)
        self.playAudio(audioClipName: questions.body[0].File_Path)
          
    }
    
    func createButtons(answers: [String]){
        
        var x: Int
        var y: Int
        var count = 0
        let numButtons = 4
        let imageName = "button-highlighted-image.jpeg"
        let image = UIImage(named: imageName)
        
        x = 30
        y = 250
        while count < numButtons{
            let button = UIButton()
            button.setTitle(answers[count], for: .normal)
            button.frame = CGRect(x:x,y:y, width:350, height:50)
            button.backgroundColor = UIColor.gray
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.setBackgroundImage(image, for: UIControl.State.highlighted)
            
            button.addTarget(self,
                             action: #selector(checkAnswer),
                             for: .touchUpInside
            )
            view.addSubview(button)
            y = y + 70
            count = count + 1
        }
       
    }
    
    @objc func checkAnswer(srcObj: UIButton){
        print("Cllicked something")
        
    }

    
    func playAudio(audioClipName: String){
        if(obj_common.offline_mode){
           // For dev use the files in Audio folder
            let path = Bundle.main.path(forResource: audioClipName, ofType:nil)!
            let url = URL(fileURLWithPath: path)
            do{
                avPlayer = try AVAudioPlayer(contentsOf: url)
                avPlayer?.play()
            }
            catch{
                print("Error loading file.")
            }
        }
        else{
          // Stream the audio from AWS S3 Bucker
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

