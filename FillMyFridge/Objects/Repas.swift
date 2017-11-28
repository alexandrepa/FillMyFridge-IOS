//
//  Repas.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation

class Repas {
    var id:Int = 0
    var nom:String
    var plats:Array<Plat> = Array()
    var numberOfPersonnes:Int
    var numero:Int
    
    init(_ id:Int, _ nom:String, _ plats:Array<Plat>, _ numberOfPersonnes:Int, _ numero:Int) {
        self.id = id
        self.nom = nom
        self.plats = plats
        self.numberOfPersonnes = numberOfPersonnes
        self.numero = numero
    }
    
    init(_ nom:String, _ plats:Array<Plat>, _ numberOfPersonnes:Int, _ numero:Int) {
        self.nom = nom
        self.plats = plats
        self.numberOfPersonnes = numberOfPersonnes
        self.numero = numero
    }
    
    init(_ nom:String, _ numberOfPersonnes:Int, _ numero:Int) {
        self.nom = nom
        self.numberOfPersonnes = numberOfPersonnes
        self.numero = numero
    }
}
