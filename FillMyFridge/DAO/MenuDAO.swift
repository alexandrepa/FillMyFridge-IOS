//
//  MenuDAO.swift
//  FillMyFridge
//
//  Created by Gerald Patelli on 28/12/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation
import SQLite

class MenuDAO {
    var database : Connection!
    var listMenuID : Int!
    let table = Table("Menu")
    let tableAssociation = Table("ListeMenus_Menu")
    let nom = Expression<String>("nom")
    let date = Expression<Int64>("date")
    let menuSql = Expression<Int64>("menu")
    let listemenusSql = Expression<Int64>("listemenus")
    
    init(_ listMenuID : Int) {
        self.database = MySQLiteHelper().connect()
        self.listMenuID = listMenuID
    }
    func createMenu(_ menu : Menu){
        do {
            let id = try database.run(table.insert(nom <- menu.nom, date <- Int64(menu.date.timeIntervalSince1970)))
            let repasDAO = RepasDAO(Int(id))
            for repas in menu.repas{
                repasDAO.createRepas(repas)
            }
            self.addMenuAssociation(Int(id))
        } catch {
            print(error)
        }
    }
    
    func addMenuAssociation(_ menuID : Int){
        do {
            try database.run(tableAssociation.insert(listemenusSql <- Int64(self.listMenuID), menuSql <- Int64(menuID)))
            
        } catch {
            print(error)
        }
    }
    
    func getMenus() -> Array<Menu> {
        var menus = [Menu]()
        do {
            for menuCursor in try database.prepare("SELECT m.id, m.nom, m.date from Menu as m, ListeMenus_Menu as lm WHERE lm.listemenus = "+String(self.listMenuID)+" AND m.id = lm.menu") {
                let menu = Menu(Int(menuCursor[0] as! Int64), menuCursor[1] as! String, Date(timeIntervalSince1970: Double(menuCursor[2] as! Int64)), [Repas]())
                
                let repasDAO = RepasDAO(Int(menu.id))
                menu.repas = repasDAO.getRepas()
                menus.append(menu)
            }
        } catch {
            print(error)
        }
        return menus
    }
}
