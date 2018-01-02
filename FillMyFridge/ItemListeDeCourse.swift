//
//  ItemListeDeCourse.swift
//  FillMyFridge
//
//  Created by Gerald Patelli on 02/01/2018.
//  Copyright © 2018 alexandre patelli. All rights reserved.
//

import Foundation

class ItemListeDeCourse{
    var grammes : Int = 0
    var descr : String = ""
    
    init(_ grammes : Int, _ descr : String) {
        self.grammes = grammes
        self.descr = descr
    }
}
