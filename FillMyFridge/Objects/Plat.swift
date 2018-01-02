//
//  Plat.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation

class Plat : CustomStringConvertible {
    var description: String {
        var description = ""
        description += "id: \(self.id)\n"
        description += "intitule: \(self.intitule)\n"
        description += "ingredients: \(self.ingredients)\n"
        description += "tags: \(self.tags)\n"
        return description
    }
    var id:Int
    var intitule:String
    var ingredients: Array<Ingredient> = Array()
    var tags: Array<Tag> = Array()
    
    init(_ id:Int, _ intitule:String, _ ingredients: Array<Ingredient>, _ tags: Array<Tag>) {
        self.id = id
        self.intitule = intitule
        self.ingredients = ingredients
        self.tags = tags
    }
    
    
}
