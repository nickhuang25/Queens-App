//
//  EntryViewController.swift
//  QueensProject
//
//  Created by Nick Huang on 5/16/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import UIKit
import os.log
import QuartzCore

class EntryViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var GLabel: UILabel!
    @IBOutlet weak var GText: UITextView!
    @IBOutlet weak var ALabel: UILabel!
    @IBOutlet weak var AText: UITextView!
    @IBOutlet weak var PLabel: UILabel!
    @IBOutlet weak var PText: UITextView!
    

    
    var entry: Gap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.GText.delegate = self
        self.AText.delegate = self
        self.PText.delegate = self

        // Do any additional setup after loading the view.
        // Set up views if editing an existing entry.
        if let entry = entry {
            navigationItem.title = "Edit Entry"
            GText.text = entry.g
            AText.text   = entry.a
            PText.text = entry.p
        }
        self.GText.layer.borderColor = UIColor.systemGray.cgColor
        self.GText.layer.borderWidth = 1.0;
        self.GText.layer.cornerRadius = 8;
        self.GText.layer.masksToBounds = false
        self.GText.layer.shadowRadius = 3.0
        self.GText.layer.shadowColor = UIColor.black.cgColor
        self.GText.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.GText.layer.shadowOpacity = 1.0
        self.AText.layer.borderColor = UIColor.systemGray.cgColor
        self.AText.layer.borderWidth = 1.0;
        self.AText.layer.cornerRadius = 8;
        self.AText.layer.masksToBounds = false
        self.AText.layer.shadowRadius = 3.0
        self.AText.layer.shadowColor = UIColor.black.cgColor
        self.AText.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.AText.layer.shadowOpacity = 1.0
        self.PText.layer.borderColor = UIColor.systemGray.cgColor
        self.PText.layer.borderWidth = 1.0;
        self.PText.layer.cornerRadius = 8;
        self.PText.layer.masksToBounds = false
        self.PText.layer.shadowRadius = 3.0
        self.PText.layer.shadowColor = UIColor.black.cgColor
        self.PText.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.PText.layer.shadowOpacity = 1.0
        GLabel.text = "I am grateful for..."
        ALabel.text = "Today's affirmation is..."
        PLabel.text = "I am proud of..."
        
        self.GText.backgroundColor = UIColor(patternImage: UIImage(named: "Gbackground")!)
        self.AText.backgroundColor = UIColor(patternImage: UIImage(named: "Abackground")!)
        self.PText.backgroundColor = UIColor(patternImage: UIImage(named: "Pbackground")!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    //MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddEntryMode = presentingViewController is UITabBarController
        if(isPresentingInAddEntryMode){
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The EntryViewController is not inside a navigation controller.")
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let gtext = GText.text ?? ""
        let atext = AText.text ?? ""
        let ptext = PText.text ?? ""
        let date1 = Date()
        
        entry = Gap(date: date1, g: gtext, a: atext, p: ptext)
    }
    

}
