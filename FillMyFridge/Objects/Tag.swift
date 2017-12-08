//
//  Tag.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation

class Tag : CustomStringConvertible {
    var description: String {
        var description = ""
        description += "id: \(self.id)\n"
        description += "label: \(self.label)\n"
        return description
    }
    var id:Int
    var label:String
    
    init(_ id:Int, _ label:String) {
        self.id = id
        self.label = label
    }
}
