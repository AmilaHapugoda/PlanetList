//
//  PlanetsViewModel.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-11.
//

import Foundation

final class PlanetsViewModel {
    
    private let url = "https://swapi.dev/api/planets/"
    
    // Show this alert on view when changed
    @Published var alertMessage: String?
    
    // drinks list
    @Published var planets: [Planet] = []
    
    // loader
    @Published var isLoading: Bool?
    
    // Get planets from Server
    func getPlanets() {
        self.isLoading = true
        HttpRequestHandler.shared.request(endPoint: url, onSuccess: {[unowned self] data in
            self.isLoading = false
            do{
                let responseObject = try JSONDecoder().decode(PlanetsResponse.self, from: data!)
                self.planets = responseObject.results
            }catch(let ex){
                print("JSON ERROR : \(ex)")
            }
        }, onFailure: { error in
            self.isLoading = false
            self.alertMessage = "ERROR :  \(error)"
        })
    }
}
