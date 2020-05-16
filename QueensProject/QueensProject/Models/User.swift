//
//  User.swift
//  QueensProject
//
//  Created by Nick Huang on 5/16/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding{
    
    var name: String = ""
    var startDate: Date?
    var goal: String = ""
    var entries: [Gap] = []
    
    
    struct PropertyKey{
        static let name = "name"
        static let startDate = "startDate"
        static let goal = "goal"
    }
    
    static let DocumentsDirectory = FileManager().urls(for:. documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("user")
    
    func encode(with coder: NSCoder){
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(startDate, forKey: PropertyKey.startDate)
        coder.encode(goal, forKey: PropertyKey.goal)
    }
    
    required convenience init?(coder: NSCoder) {
        let name = coder.decodeObject(forKey: PropertyKey.name) as? String
        let startDate = coder.decodeObject(forKey: PropertyKey.startDate) as? Date
        let goal = coder.decodeObject(forKey: PropertyKey.goal) as? String
        self.init(name: name!, startDate: startDate!, goal: goal!)
    }
    
    init(name: String, startDate: Date, goal: String){
        self.name = name
        self.startDate = startDate
        self.goal = goal
    }
    
}
