//
//  QuizViewController.swift
//  QueensProject
//
//  Created by Nick Huang on 5/16/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func quizCompleted(_ sender: Any) {
        
        user = User(name: "Tal", startDate: Date(), goal: "Be Happy")
        saveUserData()
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
