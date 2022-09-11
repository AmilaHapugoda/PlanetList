//
//  UIImageView+loadFromURL.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-11.
//

import UIKit

extension UIImageView {
    
    // laod image from a given URL
    
    func loadFrom(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
