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
    
    var imageData: Data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(planet: Planet, httpHandler: HttpRequestHandler) {
        
        self.lbl_name.text = planet.name
        self.lbl_climate.text = planet.climate
        
        //add rounded corners
        self.img_planet.layer.cornerRadius = 5
        self.img_planet.layer.masksToBounds = true
        
        if let data = self.imageData {
            self.img_planet.image = UIImage(data: data)
        }else{
            self.loadImageFromURL(url: planet.imageURL, httpHandler: httpHandler)
        }
    }
    
    func loadImageFromURL(url: String, httpHandler: HttpRequestHandler) {
        httpHandler.request(endPoint: url, onSuccess: {[weak self] data in
            if let data = data {
                DispatchQueue.main.async {
                    self?.img_planet.image = UIImage(data: data)
                }
            }
        }, onFailure: { error in
            print("ERROR Loading image:  \(error)")
        })
    }
    
}
