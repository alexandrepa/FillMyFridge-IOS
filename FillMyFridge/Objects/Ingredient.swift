//
//  Ingredient.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation

class Ingredient : CustomStringConvertible {
    var description: String {
        var description = ""
        description += "id: \(self.id)\n"
        description += "nom: \(self.nom)\n"
        description += "grammes: \(self.grammes)\n"
        return description
    }
    var id:Int
    var nom:String
    var grammes:Int
    
    init(_ id:Int, _ nom:String, _ grammes:Int){
        self.id = id
        self.nom = nom
        self.grammes = grammes
    }
}
