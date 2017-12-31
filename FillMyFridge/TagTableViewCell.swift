//
//  TagTableViewCell.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 07/12/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    let colors = ["Gourmand","Elaboré","Végétarien","Salades","Familial","Gratin","Healthy","Exotique","Variante"]
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
        let platDAO = PlatDAO(1)
        let plats = platDAO.findPlatByTag(tags)
        let randomIndex = Int(arc4random_uniform(UInt32(plats.count)))
        var selectedPlat = [Plat]()
        selectedPlat.append(plats[randomIndex])
        repas.plats = selectedPlat
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
