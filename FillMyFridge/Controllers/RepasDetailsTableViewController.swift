//
//  RepasDetailsTableViewController.swift
//  FillMyFridge
//
//  Created by Gerald Patelli on 02/01/2018.
//  Copyright © 2018 alexandre patelli. All rights reserved.
//

import UIKit

class RepasDetailsTableViewController: UITableViewController {
    var repas : Repas!
    var plat : Plat!
    override func viewDidLoad() {
        super.viewDidLoad()
        plat = repas.plats[0]
        labelNom.text = "Nom : "+repas.plats[0].intitule
        labelNbPersonnes.text = "Nombre de personnes : "+String(repas.numberOfPersonnes)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBOutlet weak var labelNbPersonnes: UILabel!
    @IBOutlet weak var labelNom: UILabel!
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
        return plat.ingredients.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ingrédients"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepasDetailsTableViewCell", for: indexPath) as? RepasDetailsTableViewCell
        var stringLabel = plat.ingredients[indexPath.row].nom+", "
        if(plat.ingredients[indexPath.row].grammes>0){
            stringLabel+=String(plat.ingredients[indexPath.row].grammes)+" grammes"
        }
        else {
           stringLabel+=String(plat.ingredients[indexPath.row].grammes*(-1))
        }
        cell?.label.text = stringLabel
        return cell!
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
