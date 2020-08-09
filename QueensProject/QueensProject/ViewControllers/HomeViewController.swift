//
//  HomeViewController.swift
//  QueensProject
//
//  Created by Nick Huang on 5/16/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var user: User?
    var quoteList: [String] = ["\"Be a first rate version of yourself, not a second rate version of someone else.\"", "\"No one can make you feel inferior without your consent.\"", "\"A girl should be two things: who and what she wants.\"", "\"You are more powerful than you know; you are beautiful just as you are.\"", "\"The question isn’t who’s going to let me; it’s who is going to stop me.\"", "\"You may not control all the events that happen to you, but you can decide not to be reduced by them.\"", "\"Think like a queen. A queen is not afraid to fail. Failure is another stepping stone to greatness.\"", "\"The future belongs to those who believe in the beauty of their dreams.\"", "\"I’m not afraid of storms, for I’m learning to sail my ship.\"", "\"Let us make our future now, and let us make our dreams tomorrow's reality.\""]
    var attrList: [String] = ["Judy Garland", "Eleanor Roosevelt", "Coco Chanel", "Melissa Etheridge", "Ayn Rand", "Maya Angelou", "Oprah Winfrey", "Eleanor Roosevelt", "Louisa May Alcott", "Malala Yousafzai"]
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var excitementLabel: UILabel!
    @IBOutlet weak var attrLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = loadUserData()
        print("DATA RETRIEVED")
        print(user!.name)
        logoImage.image = UIImage(named: "Logo")
        // Do any additional setup after loading the view.
        greetingLabel.text = "Welcome " + user!.name + "!"
        generateQuote()
        //nextButton.setTitle("Upload", for: .normal)
    }
    
    func generateQuote(){
        let number = Int.random(in: 0 ... 9)
        excitementLabel.text = quoteList[number]
        attrLabel.text = attrList[number]
    }
    

    @IBAction func nextClicked(_ sender: Any) {
        performSegue(withIdentifier: "homeToFeed", sender: self)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let nextView = segue.destination as! GapTableViewController
        nextView.user = self.user
    }*/
    
    private func loadUserData() -> User{
        return (NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? User)!
    
    }
}
