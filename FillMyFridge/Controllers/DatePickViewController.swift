//
//  DatePickViewController.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import UIKit

class DatePickViewController: UIViewController, UITabBarControllerDelegate {
    var dateDebut : Date = Date()
    var dateFin : Date = Date()


    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
        // Do any additional setup after loading the view.
    }
    

    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let firstVC = tabBarController.viewControllers?[1] as! UINavigationController
        firstVC.popToRootViewController(animated: false)
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
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MealNumberTableViewController
        destinationVC.dateDebut = dateDebut
        destinationVC.dateFin = dateFin
        
        
    }
    
    /*func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let destinationVC = segue.destinationViewController as! MealNumberTableViewController
        destinationVC.dateDebut = dateDebut
        destinationVC.dateFin = dateFin
    }*/

}
