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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
