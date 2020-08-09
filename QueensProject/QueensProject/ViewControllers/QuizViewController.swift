//
//  QuizViewController.swift
//  QueensProject
//
//  Created by Nick Huang on 5/16/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var goalText: UITextField!
    @IBOutlet weak var goal2Text: UITextView!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func quizCompleted(_ sender: Any) {
        user = User(name: nameText.text ?? "", startDate: Date(), goal: goalText.text ?? "", profilepic: UIImage(named: "Profile")!, weekStartDate: Date(), weekUses: 0)
        saveUserData()
        performSegue(withIdentifier: "quizToHome", sender: self)
    }
    
    
    private func saveUserData(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(user as Any, toFile: User.ArchiveURL.path)
        
        if(isSuccessfulSave){
            print("User data successfully saved")
        }
        else{
            print("Failed to save user data")
        }
    }
}
