//
//  DatePickViewController.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import UIKit

class DatePickViewController: UIViewController {
    var dateDebut : Date = Date()
    var dateFin : Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dateDebutChanged(_ sender: UIDatePicker) {
        dateDebut = sender.date
    }
    
    
    @IBAction func dateFinChanged(_ sender: UIDatePicker) {
        dateFin = sender.date
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        print("DateDebut:"+dateDebut.description)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
