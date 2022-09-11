//
//  PlanetDetailsViewController.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-11.
//

import UIKit

class PlanetDetailsViewController: UIViewController {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_orbitalPeriod: UILabel!
    @IBOutlet weak var lbl_gravity: UILabel!
    @IBOutlet weak var img_planetImage: UIImageView!
    
    public var planet: Planet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func setupUI() {
        // get image from url
        self.img_planetImage.loadFrom(url: self.planet.imageURL)
        self.img_planetImage.layer.cornerRadius = 10
        self.img_planetImage.layer.masksToBounds = true
        
        // setup labels
        self.lbl_name.text = self.planet.name
        self.lbl_orbitalPeriod.text = "Orbital Period: \(self.planet.orbital_period)"
        self.lbl_gravity.text = "Gravity: \(self.planet.gravity)"
    }
}
