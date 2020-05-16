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
    var quoteList: [String] = []
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var excitementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        greetingLabel.text = "Welcome" + user!.name
    }
    
    func generateQuote(){
        
    }
    

    @IBAction func nextClicked(_ sender: Any) {
        performSegue(withIdentifier: "homeToFeed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let nextView = segue.destination as! HomeViewController
        nextView.user = self.user
    }
}
