//
//  ViewController.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let SQLHelper = MySQLiteHelper()
        
        let fileManager = FileManager.default
        let path = SQLHelper.getPathString()
        
        if !fileManager.fileExists(atPath: path){
            SQLHelper.connect()
            SQLHelper.createDatabases()
        }
        let platDAO = PlatDAO(1)
        /*let plat = Plat(1, "", [Ingredient](), [Tag]())
        platDAO.addPlat(plat)*/
        var tags = [Tag]()
        tags.append(Tag(1, ""))
        print(String(describing: platDAO.findPlatByTag(tags)))
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

