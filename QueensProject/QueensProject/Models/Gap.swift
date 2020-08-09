//
//  Gap.swift
//  QueensProject
//
//  Created by Nick Huang on 5/16/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import Foundation
import os.log

class Gap: NSObject, NSCoding{
    func encode(with coder: NSCoder) {
        coder.encode(g, forKey: PropertyKey.g)
        coder.encode(a, forKey: PropertyKey.a)
        coder.encode(p, forKey: PropertyKey.p)
    }
    
    required convenience init?(coder: NSCoder) {
        let g = coder.decodeObject(forKey: PropertyKey.g) as! String
        let a = coder.decodeObject(forKey: PropertyKey.a) as! String
        let p = coder.decodeObject(forKey: PropertyKey.p) as! String
        // Must call designated initializer.
        self.init(date: Date(), g: g, a: a, p: p)
    }
    
    var date: Date?
    var g:String = ""
    var a:String = ""
    var p:String = ""
    
    init(date: Date, g: String, a: String, p: String){
        self.date = date;
        self.g = g;
        self.a = a;
        self.p = p;
    }
    
struct PropertyKey {
    static let g = "g"
    static let a = "a"
    static let p = "p"
}
    //MARK: Archiving Paths
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("entries")
}
