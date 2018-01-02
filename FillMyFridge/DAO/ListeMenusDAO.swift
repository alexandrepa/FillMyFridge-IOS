//
//  ListeMenusDAO.swift
//  FillMyFridge
//
//  Created by Gerald Patelli on 28/12/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation
import SQLite

class ListeMenusDAO {
    var database : Connection!
    let dateDebut = Expression<Int64>("date_debut")
    let dateFin = Expression<Int64>("date_fin")
    let table = Table("ListeMenus")

    init() {
        self.database = MySQLiteHelper().connect()
    }
    func createListeMenus(_ listeMenus : ListeMenus) -> ListeMenus{
        do {
            let id = try database.run(table.insert(dateDebut <- Int64(listeMenus.dateDebut.timeIntervalSince1970), dateFin <- Int64(listeMenus.dateFin.timeIntervalSince1970)))
            let menuDAO = MenuDAO(Int(id))
            for menu in listeMenus.menus{
                menuDAO.createMenu(menu)
            }
        } catch {
            print(error)
        }
        return listeMenus
    }
    
    func cursorToListeMenus (_ cursor : Array<Any>) -> ListeMenus {
        let id = Int(cursor[0] as! Int64)
        let debut = cursor[1] as! Int64
        let fin = cursor[2] as! Int64
        
        let listeMenus = ListeMenus(id, Date(timeIntervalSince1970:Double(debut)), Date(timeIntervalSince1970:Double(fin)), [Menu]())

        return listeMenus
    }
    
    func getListeMenus(_ id: Int) -> ListeMenus {
        var listeMenus = ListeMenus(Date(), Date())
        do {
            for listeMenusCursor in try database.prepare("SELECT * from ListeMenus WHERE id = "+String(id)+";") {
                listeMenus = self.cursorToListeMenus(listeMenusCursor)
                
                let menuDAO = MenuDAO(Int(id))
                listeMenus.menus = menuDAO.getMenus()
            }
        } catch {
            print(error)
        }
        return listeMenus
    }
    
    func getAllListeMenus() -> Array<ListeMenus>{
        var arrayListeMenus = [ListeMenus]()
        do {
            for listeMenusCursor in try database.prepare("SELECT * from ListeMenus;") {
                let listeMenus = self.cursorToListeMenus(listeMenusCursor)
                arrayListeMenus.append(listeMenus)
            }
        } catch {
            print(error)
        }
        return arrayListeMenus
    }
}
