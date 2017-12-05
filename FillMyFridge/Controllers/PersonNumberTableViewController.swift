//
//  PersonNumberTableViewController.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 29/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import UIKit

class PersonNumberTableViewController: UITableViewController {
    var listeMenus : ListeMenus!
    var menu : Menu!
    var nbRow : Int = 1
    var lastOne : Bool = false

    @IBAction func ValueChangedSlider(_ sender: UISlider) {
        sender.setValue(sender.value.rounded(.down), animated: true)
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        menu.repas[indexPath![1]].numberOfPersonnes = Int(sender.value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ListeMenu:"+String(listeMenus.menus[1].repas.count))
        var indexMenu:Int = 0
        while listeMenus.menus.count>indexMenu && listeMenus.menus[indexMenu].repas[0].numberOfPersonnes != 0 {
            indexMenu = indexMenu + 1
        }
        if(indexMenu == listeMenus.menus.count){
            performSegue(withIdentifier: "TagSegue", sender: self)
            lastOne = true
        }
        else{
           menu = listeMenus.menus[indexMenu]
            nbRow = menu.repas.count
            
        }
        

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonNumberTableViewCell", for: indexPath) as? PersonNumberTableViewCell
        if(!lastOne){
            let repas : Repas = menu.repas[indexPath.row]
            // Configure the cell...
            cell?.labelName.text = repas.nom
        }
        
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "PersonNumberAgainSegue"){
            let destinationVC = segue.destination as! PersonNumberTableViewController
            destinationVC.listeMenus = listeMenus
        }
        else {
            let destinationVC = segue.destination as! TagTableViewController
            destinationVC.listeMenus = listeMenus
        }
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
