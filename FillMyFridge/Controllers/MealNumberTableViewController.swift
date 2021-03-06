//
//  MealNumberTableViewController.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 28/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import UIKit

class MealNumberTableViewController: UITableViewController {
    var dateDebut : Date = Date()
    var dateFin : Date = Date()
    var listeMenus : ListeMenus!
    var nbRow : Int = 1

    @IBAction func ValueChangedSlider(_ sender: UISlider) {
        sender.setValue(sender.value.rounded(.down), animated: true)
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        var repas = [Repas]()
        for i in 1...Int(sender.value) {
            repas.append(Repas("Repas n°"+String(i), 0, Int(i)))
        }
        listeMenus.menus[indexPath![1]].repas = repas
        var label = sender.superview?.viewWithTag(15) as! UILabel
        label.text = String(Int(sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DateDebut:"+dateDebut.description)
        print("DateFin:"+dateFin.description)
        listeMenus = ListeMenus(dateDebut, dateFin)
        nbRow = listeMenus.getNumberOfMeals()
        var menus = [Menu]()
        
        
        for index in 0...nbRow-1 {
            let date:Date = Calendar.current.date(byAdding: .day, value: index, to: dateDebut)!
            var arrayRepas = [Repas]()
            arrayRepas.append(Repas("Repas n°1", 0, 1))
            let menu = Menu(listeMenus.getStringDate(date), date, arrayRepas)
            menus.append(menu)
        }
        listeMenus.menus = menus


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nbRow
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as? MealTableViewCell
        let menu : Menu = listeMenus.menus[indexPath.row]
        // Configure the cell...
        cell?.labelDate.text = menu.nom
        cell?.menu = menu
        //cell?.sliderNumberMeal.addTarget(self, action: <#T##Selector#>, for: <#T##UIControlEvents#>)

        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PersonNumberTableViewController
        destinationVC.listeMenus = listeMenus
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
