//
//  ListeMenus.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation

class ListeMenus  {
    var id : Int = 0
    var dateDebut : Date
    var dateFin : Date
    var menus : Array<Menu> = Array()
    
    init(_ id:Int, _ dateDebut:Date, _ dateFin:Date, _ menus:Array<Menu>) {
        self.id = id
        self.dateDebut = dateDebut
        self.dateFin = dateFin
        self.menus = menus
    }
    
    init(_ dateDebut:Date, _ dateFin:Date, _ menus:Array<Menu>) {
        self.dateDebut = dateDebut
        self.dateFin = dateFin
        self.menus = menus
    }
    
    init(_ dateDebut:Date, _ dateFin:Date) {
        self.dateDebut = dateDebut
        self.dateFin = dateFin
    }
    func getNumberOfMeals() -> Int {
        return Calendar.current.dateComponents([.day], from: dateDebut, to: dateFin).day! + 1
    }
    func getStringDate(_ date:Date) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM"
        let resultString = inputFormatter.string(from: date)
        return resultString
    }
    
    
}

