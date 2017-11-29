//
//  MealTableViewCell.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 29/11/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var sliderNumberMeal: UISlider!
    var menu : Menu!
    
    @IBAction func TouchDrag(_ sender: UISlider) {
        print("slider:"+String(sender.value))
        var repas = [Repas]()
        for index in 1...Int(sender.value) {
            repas.append(Repas("Repas n°"+String(index), 0, index))
        }
        menu.repas = repas
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func TouchUpOutside(_ sender: UISlider) {
        print("slider:"+String(sender.value))
        var repas = [Repas]()
        for index in 1...Int(sender.value) {
            repas.append(Repas("Repas n°"+String(index), 0, index))
        }
        menu.repas = repas
    }
    @IBAction func TouchDragOutside(_ sender: UISlider) {
        print("slider:"+String(sender.value))
        var repas = [Repas]()
        for index in 1...Int(sender.value) {
            repas.append(Repas("Repas n°"+String(index), 0, index))
        }
        menu.repas = repas
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func CHanged(_ sender: UISlider) {
        //sender.setValue(sender.value.rounded(.down), animated: true)
    }
    
}
