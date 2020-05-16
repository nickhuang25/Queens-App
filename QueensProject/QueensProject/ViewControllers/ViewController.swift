//
//  ViewController.swift
//  QueensProject
//
//  Created by Nick Huang on 2/9/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        nextStep()
    }

    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        }
        else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    func nextStep(){
        var firstLaunch = isAppAlreadyLaunchedOnce()
        if(firstLaunch == false){
            print("TAKE QUIZ")
            performSegue(withIdentifier: "launchToQuiz", sender: self)
        }
        else{
            //Retrieve Data from the Device
            user = loadUserData()
            print("DATA RETRIEVED")
            print(user!.name)
            performSegue(withIdentifier: "launchToHome", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let nextView = segue.destination as! HomeViewController
        nextView.user = self.user
    }
    
    private func loadUserData() -> User{
        return (NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? User)!
    }

}

