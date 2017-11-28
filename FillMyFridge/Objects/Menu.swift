//
//  Menu.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation

class Menu {
    var id: Int = 0
    var nom: String
    var date: Date
    var repas : Array<Repas> = Array()
    
    init(_ id:Int, _ nom:String, _ date:Date, repas:Array<Repas>) {
        self.id = id
        self.nom = nom
        self.date = date
        self.repas = repas
    }
    
    init(_ nom:String, _ date:Date, repas:Array<Repas>) {
        self.nom = nom
        self.date = date
        self.repas = repas
    }
    
    init(_ nom:String, _ date:Date) {
        self.nom = nom
        self.date = date
    }
    
}
