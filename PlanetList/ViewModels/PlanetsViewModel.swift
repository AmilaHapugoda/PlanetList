//
//  PlanetsViewModel.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-11.
//

import Foundation

final class PlanetsViewModel {
    
    public var url: String? = "https://swapi.dev/api/planets/"
    var httpHandler: HttpRequestHandlerProtocol!
    
    // Show this alert on view when changed
    @Published var alertMessage: String?
    
    // drinks list
    @Published var planets: [Planet] = []
    
    // loader
    @Published var isLoading: Bool?
    
    
    init(httpHandler: HttpRequestHandlerProtocol) {
        self.httpHandler = httpHandler
    }
    
    // Get planets from Server
    func getPlanets() {
        if let url = self.url {
            self.isLoading = true
            httpHandler.request(endPoint: url, onSuccess: {[unowned self] data in
                self.isLoading = false
                do{
                    let responseObject = try JSONDecoder().decode(NetworkResponse<Planet>.self, from: data!)
                    self.planets = self.planets + responseObject.results
                    self.url = responseObject.next
                }catch(let ex){
                    print("JSON ERROR : \(ex)")
                }
            }, onFailure: { error in
                self.isLoading = false
                self.alertMessage = "ERROR :  \(error)"
            })
        }
    }
}
