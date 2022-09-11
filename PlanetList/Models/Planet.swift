//
//  Planet.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-11.
//

import Foundation

struct Planet: Decodable {
    let name: String
    let climate: String
    let orbital_period: String
    let gravity: String
    
    // create image URL
    var imageURL: String {
        let nameWithoutSpaces = self.name.replacingOccurrences(of: " ", with: "")
        return "https://picsum.photos/seed/\(nameWithoutSpaces)/200/"
    }
}
