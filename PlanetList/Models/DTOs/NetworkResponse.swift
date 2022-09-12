//
//  NetworkResponse.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-12.
//

import Foundation

struct NetworkResponse<T: Decodable>: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]
}
