//
//  PlatDAO.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 08/12/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation
import SQLite

class PlatDAO {
    var database : Connection!
    var repasID : Int!
    let table = Table("Repas_Plat")
    let platId = Expression<Int64>("plat")
    let repasId = Expression<Int64>("repas")
    
    init(_ repasID : Int) {
        self.database = MySQLiteHelper().connect()
        self.repasID = repasID
    }
    func addPlat(_ plat : Plat){
        do {
            try database.run(table.insert(platId <- Int64(plat.id), repasId <- Int64(self.repasID)))
        } catch {
            print(error)
        }
    }
    func getPlats() -> Array<Plat> {
        do {
            for plat in try database.prepare("SELECT DISTINCT p.id, p.intitule from Plat as p;") {
                print("id: \(plat[0]), intitule: \(plat[1])")
            }
        } catch {
            print(error)
        }
        return [Plat]()
    }
}
