//
//  PlanetListTableViewCell.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-11.
//

import UIKit

class PlanetListTableViewCell: UITableViewCell {

    @IBOutlet weak var img_planet: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_climate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(planet: Planet) {
        
        self.lbl_name.text = planet.name
        self.lbl_climate.text = planet.climate
        
        // Load Image form URL
        self.img_planet.loadFrom(url: planet.imageURL)
        
        //add rounded corners
        self.img_planet.layer.cornerRadius = 5
        self.img_planet.layer.masksToBounds = true
    }
    
}
