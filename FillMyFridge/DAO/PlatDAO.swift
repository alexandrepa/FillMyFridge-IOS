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
    var idPlatsAdded = [Int]()
    
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
    func findPlatByTag(_ tags : Array<Tag>)  -> Array<Plat> {
        var selectTag = ""
        var selectPlatId = ""
        for tag in tags{
            selectTag+="'"+String(tag.id)+"',"
        }
        selectTag.remove(at: selectTag.index(before: selectTag.endIndex))
        if idPlatsAdded.count == 0 {
            idPlatsAdded.append(0)
        }
        for idPlat in idPlatsAdded{
            selectPlatId+="'"+String(idPlat)+"',"
        }
        selectPlatId.remove(at: selectPlatId.index(before: selectPlatId.endIndex))
        
        var plats = [Plat]()
        do {
            for platCursor in try database.prepare("SELECT DISTINCT p.id, p.intitule from Plat as p, Tag as t, Plat_Tag as pt WHERE t.id IN ("+selectTag+") AND pt.tag = t.id AND pt.plat = p.id AND p.id NOT IN ("+selectPlatId+");") {
                let plat = cursorToPlat(platCursor)
                plats.append(plat)
            }
        } catch {
            print(error)
        }
        if(plats.count == 0){
            self.idPlatsAdded = [Int]()
            self.idPlatsAdded.append(0)
            selectPlatId = "'"+String(0)+"'"
            do {
                for platCursor in try database.prepare("SELECT DISTINCT p.id, p.intitule from Plat as p, Tag as t, Plat_Tag as pt WHERE t.id IN ("+selectTag+") AND pt.tag = t.id AND pt.plat = p.id AND p.id NOT IN ("+selectPlatId+");") {
                    let plat = cursorToPlat(platCursor)
                    plats.append(plat)
                }
            } catch {
                print(error)
            }
        }
        return plats
        
    }
    func cursorToPlat(_ cursor : Array<Any>) -> Plat {
        let id = Int(cursor[0] as! Int64)
        var tags = [Tag]()
        do {
            for tagCursor in try database.prepare("SELECT DISTINCT t.id, t.label from Tag as t, Plat_Tag as pt WHERE pt.plat = "+String(id)+" AND pt.tag = t.id") {
                let tag = Tag(Int(tagCursor[0] as! Int64), tagCursor[1] as! String)
                tags.append(tag)
            }
        } catch {
            print(error)
        }
        var ingredients = [Ingredient]()
        do {
            for ingredientCursor in try database.prepare("SELECT DISTINCT i.id, i.nom, pi.grammes from Ingredient as i, Plat_Ingredient as pi WHERE pi.plat = "+String(id)+" AND pi.ingredient = i.id") {
                let ingredient = Ingredient(Int(ingredientCursor[0] as! Int64), ingredientCursor[1] as! String, Int(ingredientCursor[2] as! Int64))
                ingredients.append(ingredient)
            }
        } catch {
            print(error)
        }
        let plat = Plat(id, cursor[1] as! String, ingredients, tags)
        return plat
    }
    func addPlatAdded(_ plat : Plat){
        idPlatsAdded.append(plat.id)
    }
    func getPlats() -> Array<Plat> {
        var plats = [Plat]()
        do {
            for platCursor in try database.prepare("SELECT DISTINCT p.id, p.intitule from Plat as p, Repas_Plat as rp WHERE rp.repas = "+String(self.repasID)+" AND p.id = rp.plat;") {
                let plat = cursorToPlat(platCursor)
                plats.append(plat)
            }
        } catch {
            print(error)
        }
        return plats
    }
}
