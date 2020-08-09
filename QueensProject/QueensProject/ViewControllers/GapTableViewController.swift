//
//  GapTableViewController.swift
//  QueensProject
//
//  Created by Morgan Ruffner on 5/28/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import UIKit
import os.log
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}


class GapTableViewController: UITableViewController {
    var user: User?
    //MARK: properties
    
    var entries = [Gap]()
    
    let calendar = Calendar.current

    override func viewDidLoad() {
        super.viewDidLoad()
        user = loadUserData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.backgroundView = UIImageView(image: UIImage(named: "Feed Background"))

        if let savedEntries = loadEntries() {
            entries += savedEntries
        }
        else{
            //loadSampleEntries()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EntryCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EntryCell  else {
            fatalError("The dequeued cell is not an instance of EntryCell.")
        }
        let entry = entries[indexPath.row]
        cell.DateLabel.text = entry.date?.toString(dateFormat: "MM-dd")
        cell.EntryLabel.text = "I am grateful for: " + entry.g + "\n Today's affirmation is: " + entry.a + "\n I am proud of: " + entry.p
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            entries.remove(at: indexPath.row)
            saveEntries()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "AddItem":
            os_log("Adding a new entry.", log: OSLog.default, type: .debug)
            case "ShowDetail":
            guard let entrydetailViewController = segue.destination as? EntryViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
             
            guard let selectedEntryCell = sender as? EntryCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
             
            guard let indexPath = tableView.indexPath(for: selectedEntryCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
             
            let selectedEntry = entries[indexPath.row]
            entrydetailViewController.entry = selectedEntry
            /*case "feedToHome":
                performSegue(withIdentifier: "feedToHome", sender: self)*/
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    // MARK: Private methods
    //MARK: Actions
    /*@IBAction func backToHome(_ sender: Any) {
        performSegue(withIdentifier: "feedToHome", sender: self)
    }*/
    
    @IBAction func unwindToGapList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EntryViewController, let entry = sourceViewController.entry {
    
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Edit existing entry
                entries[selectedIndexPath.row] = entry
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                // Add a new entry.
                let newIndexPath = IndexPath(row: entries.count, section: 0)
                entries.append(entry)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                //track usage
                let timeint = calendar.dateComponents([.day], from: user!.weekStartDate!, to: Date())
                if(timeint.day! > 7){
                    user!.weekStartDate = Date()
                    user!.weekUses = 1
                }
                else{
                    user!.weekUses += 1
                }
                
            }
            // Save the entries.
            saveEntries()
            saveUserData()
        }
    }
    
    private func loadSampleEntries(){
        let date1 = Date()
        let g1 = "This is a sample entry"
        let a1 = " "
        let p1 = " "
        let gap1 = Gap(date: date1, g: g1, a: a1, p: p1)
        entries += [gap1]
    }
    
    private func saveEntries() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(entries, toFile: Gap.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Entries successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save entries...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadEntries() -> [Gap]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Gap.ArchiveURL.path) as? [Gap]
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
