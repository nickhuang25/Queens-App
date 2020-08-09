//
//  User.swift
//  QueensProject
//
//  Created by Nick Huang on 5/16/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject, NSCoding{
    
    var name: String = ""
    var startDate: Date?
    var goal: String = ""
    var entries: [Gap] = []
    var profilepic: UIImage = UIImage(named: "Profile")!
    var weekStartDate : Date?
    var weekUses: UInt
    
    
    
    struct PropertyKey{
        static let name = "name"
        static let startDate = "startDate"
        static let goal = "goal"
        static let profilepic = "profilepic"
        static let weekStartDate = "weekStartDate"
        static let weekUses = "weekUses"
    }
    
    static let DocumentsDirectory = FileManager().urls(for:. documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("user")
    
    func encode(with coder: NSCoder){
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(startDate, forKey: PropertyKey.startDate)
        coder.encode(goal, forKey: PropertyKey.goal)
        coder.encode(profilepic, forKey: PropertyKey.profilepic)
        coder.encode(weekStartDate, forKey: PropertyKey.weekStartDate)
        coder.encode(weekUses, forKey: PropertyKey.weekUses)
    }
    
    required convenience init?(coder: NSCoder) {
        let name = coder.decodeObject(forKey: PropertyKey.name) as? String
        let startDate = coder.decodeObject(forKey: PropertyKey.startDate) as? Date
        let goal = coder.decodeObject(forKey: PropertyKey.goal) as? String
        let profilepic = coder.decodeObject(forKey: PropertyKey.profilepic) as? UIImage
        let weekStartDate = coder.decodeObject(forKey: PropertyKey.weekStartDate) as? Date
        let weekUses = coder.decodeObject(forKey: PropertyKey.weekUses) as? UInt
        self.init(name: name!, startDate: startDate!, goal: goal!, profilepic: profilepic!, weekStartDate: weekStartDate!, weekUses: weekUses!)
    }
    
    init(name: String, startDate: Date, goal: String, profilepic: UIImage, weekStartDate: Date, weekUses: UInt){
        self.name = name
        self.startDate = startDate
        self.goal = goal
        self.profilepic = profilepic
        self.weekStartDate = weekStartDate
        self.weekUses = weekUses
    }
    
}
