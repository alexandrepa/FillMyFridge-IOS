//
//  Ingredient.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation

class Ingredient {
    var id:Int
    var nom:String
    var grammes:Int
    
    init(_ id:Int, _ nom:String, _ grammes:Int){
        self.id = id
        self.nom = nom
        self.grammes = grammes
    }
}
