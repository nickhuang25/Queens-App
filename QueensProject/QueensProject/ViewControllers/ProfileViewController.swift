//
//  ProfileViewController.swift
//  QueensProject
//
//  Created by Morgan Ruffner on 7/25/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user: User?
    @IBOutlet weak var profileimg: UIImageView!
    @IBAction func editpic(_ sender: Any) {
        importPicture()
    }
    @IBOutlet weak var datelabel: UILabel!
    
    @IBOutlet weak var circularprogressbar: CircularProgressBar!
    @IBOutlet weak var nametext: UITextField!
    @IBOutlet weak var progressLabel: UILabel!
    override func viewDidLoad() {
    super.viewDidLoad()
    user = loadUserData()
    profileimg.image = user!.profilepic
    nametext.text = user!.name
    datelabel.textAlignment = NSTextAlignment.center;
    datelabel.text = "User since " + (user!.startDate?.toString(dateFormat: "MM-dd"))!
    profileimg.layer.borderWidth = 1
    profileimg.layer.masksToBounds = false
    profileimg.layer.borderColor = UIColor.white.cgColor
    profileimg.layer.cornerRadius = profileimg.frame.height/2
    profileimg.clipsToBounds = true
    print(Int(user!.weekUses))
    print(Int(user!.goal)!)
    let progress = Double(Double(user!.weekUses)/Double(user!.goal)!)
    //let progress = 0.5
    print(progress)
    circularprogressbar.setProgress(to: progress, withAnimation: true)
    //circularprogressbar.safePercent = Int(progress*100)
    circularprogressbar.label.text = String(user!.weekUses) + "/" + String(user!.goal)
    progressLabel.text = "You are " + String(Int(progress*100)) + "% of the way to your weekly goal!"
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)

        profileimg.image = image
        user!.profilepic = profileimg.image!
        saveUserData()
    }
    
    private func loadUserData() -> User{
        return (NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? User)!
    
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
