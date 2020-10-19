//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Robert Guerra on 7/15/20.
//  Copyright © 2020 Robert Guerra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    // IBOutlet Properties
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    // Coded Properties
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questions = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany",
                      "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia",
                      "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestions()
    }
    
    func askQuestions(action: UIAlertAction? = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "Question \(questions) | \(countries[correctAnswer].uppercased()) | Score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong\n Selected Flag: \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        if questions == 10 {
            title = "Quiz Complete!"
            let alert = UIAlertController(title: title,
                                          message: "Final score: \(score).",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart",
                                          style: .default,
                                          handler: askQuestions))
            present(alert, animated: true)
            questions = 1
            score = 0
        } else {
            let alert = UIAlertController(title: title,
                                       message: "Your score is \(score).",
                                       preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue",
                                       style: .default,
                                       handler: askQuestions))
            present(alert, animated: true)
            questions += 1
        }
    }
}

