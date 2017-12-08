//
//  MySQLiteHelper.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 08/12/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation
import SQLite

class MySQLiteHelper {
    var db : Connection!
    
    func connect() -> Connection {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        do {
            try db = try Connection("\(path)/db.sqlite3")
        } catch {
            print(error)
        }
        return db
    }
    
    
}
