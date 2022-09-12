//
//  MockHttpRequestHandler.swift
//  PlanetListTests
//
//  Created by Amila Prasad on 2022-09-12.
//

import Foundation
@testable import PlanetList

final class MockHttpRequestHandler: HttpRequestHandlerProtocol, Mockable{
    func request(endPoint: String,
                 onSuccess: @escaping (Data?) -> Void,
                 onFailure: @escaping (String) -> Void) {
        onSuccess (loadJson(fileName: "PlanetsListResponse"))
    }
}
