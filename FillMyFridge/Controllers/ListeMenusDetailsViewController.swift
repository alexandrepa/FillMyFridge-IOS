//
//  ListeMenusDetailsViewController.swift
//  FillMyFridge
//
//  Created by Gerald Patelli on 02/01/2018.
//  Copyright © 2018 alexandre patelli. All rights reserved.
//

import UIKit

class ListeMenusDetailsViewController: UITableViewController {
    var listeMenus : ListeMenus!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelDates.text = "Du "+listeMenus.getStringDate(listeMenus.dateDebut)+" au "+listeMenus.getStringDate(listeMenus.dateFin)+" :"
        // Do any additional setup after loading the view.
        let listeMenusDAO = ListeMenusDAO()
        listeMenus = listeMenusDAO.getListeMenus(listeMenus.id)
    }

    @IBOutlet weak var labelDates: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return listeMenus.menus.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listeMenus.menus[section].description
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listeMenus.menus[section].repas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListeMenusDetailsTableViewCell", for: indexPath) as? ListeMenusDetailsTableViewCell
        let repas = listeMenus.menus[indexPath.section].repas[indexPath.row]
        
        cell?.label.text = repas.description
        cell?.repas = repas
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ListeMenusDetailsViewController
        //destinationVC.listeMenus = listeMenus[(tableView.indexPathForSelectedRow?.row)!]
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
