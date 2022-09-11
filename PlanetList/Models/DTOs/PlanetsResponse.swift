//
//  PlanetsResponse.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-11.
//

import Foundation

struct PlanetsResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Planet]
}
