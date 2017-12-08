//
//  TagTableViewCell.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 07/12/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    let colors = ["Gourmand","Healthy","Green","Blue"]
    var repas : Repas!
    @IBOutlet weak var pickerView: UIPickerView!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var tags = [Tag]()
        tags.append(Tag(row+1, colors[row]))
        var plats = [Plat]()
        plats.append(Plat(0, "Plat", [Ingredient](), tags))
        repas.plats = plats
        repas.id = 1
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.delegate = self
        pickerView.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
