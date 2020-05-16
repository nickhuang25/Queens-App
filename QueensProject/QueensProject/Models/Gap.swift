//
//  Gap.swift
//  QueensProject
//
//  Created by Nick Huang on 5/16/20.
//  Copyright © 2020 Nick Huang. All rights reserved.
//

import Foundation

class Gap{
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
}
