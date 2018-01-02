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
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func onButtonCreate(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    @IBAction func onButtonShow(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBOutlet weak var buttonCreate: UIButton!
    @IBOutlet weak var buttonShowList: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

