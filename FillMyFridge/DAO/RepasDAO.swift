//
//  RepasDAO.swift
//  FillMyFridge
//
//  Created by Gerald Patelli on 27/12/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation
import SQLite

class RepasDAO {
    var database : Connection!
    var menuID : Int!
    let table = Table("Repas")
    let tableAssociation = Table("Menu_Repas")
    let nom = Expression<String>("nom")
    let personnes = Expression<Int64>("personnes")
    let numero = Expression<Int64>("numero")
    let menuSql = Expression<Int64>("menu")
    let repasSql = Expression<Int64>("repas")
    var idPlatsAdded = [Int]()
    
    init(_ menuID : Int) {
        self.database = MySQLiteHelper().connect()
        self.menuID = menuID
    }
    func createRepas(_ repas : Repas){
        do {
            let id = try database.run(table.insert(nom <- repas.nom, personnes <- Int64(repas.numberOfPersonnes), numero <- Int64(repas.numero)))
            let platDAO = PlatDAO(Int(id))
            for plat in repas.plats{
                platDAO.addPlat(plat)
            }
            self.addRepasAssociation(Int(id))
        } catch {
            print(error)
        }
    }
    
    func cursorToRepas (_ cursor : Array<Any>) -> Repas {
        let id = Int(cursor[0] as! Int64)
        let nom = cursor[1] as! String
        let personnes = Int(cursor[2] as! Int64)
        let numero = Int(cursor[3] as! Int64)
        let repas = Repas(id, nom, [Plat](),personnes,numero)
        return repas
    }
    
    func addRepasAssociation(_ repasID : Int){
        do {
            try database.run(tableAssociation.insert(menuSql <- Int64(self.menuID), repasSql <- Int64(repasID)))
            
        } catch {
            print(error)
        }
    }
    
    func getRepas() -> Array<Repas> {
        var arrayRepas = [Repas]()
        do {
            for repasCursor in try database.prepare("SELECT r.id, r.nom, r.personnes, r.numero from Repas as r, Menu_Repas as mr WHERE mr.menu = "+String(self.menuID)+" AND r.id = mr.repas") {
                let repas = cursorToRepas(repasCursor)
                
                let platDAO = PlatDAO(Int(repas.id))
                repas.plats = platDAO.getPlats()
                
                arrayRepas.append(repas)
            }
        } catch {
            print(error)
        }
        return arrayRepas
    }
}
