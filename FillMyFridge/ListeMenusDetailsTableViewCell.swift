//
//  ListeMenusDetailsTableViewCell.swift
//  FillMyFridge
//
//  Created by Gerald Patelli on 02/01/2018.
//  Copyright © 2018 alexandre patelli. All rights reserved.
//

import UIKit

class ListeMenusDetailsTableViewCell: UITableViewCell {
    var repas : Repas!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var label: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
