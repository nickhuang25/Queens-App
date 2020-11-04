//
//  InstructionsViewController.swift
//  QueensProject
//
//  Created by Morgan Ruffner on 11/4/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import Foundation
import UIKit

class InstructionsViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func instrCompleted(_ sender: Any) {
        performSegue(withIdentifier: "instrToHome", sender: self)
    }
    
}
