//
//  Mockable.swift
//  PlanetListTests
//
//  Created by Amila Prasad on 2022-09-12.
//

import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    
    func loadJson(fileName: String) -> Data
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJson(fileName: String) -> Data {
        guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Failed to load json file")
        }
        
        do {
            let data = try Data(contentsOf: path)
            return data
        } catch {
            fatalError("Json data loader failed")
        }
    }
}
