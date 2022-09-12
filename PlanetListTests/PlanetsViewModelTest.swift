//
//  PlanetsViewModelTest.swift
//  PlanetListTests
//
//  Created by Amila Prasad on 2022-09-12.
//

import XCTest
import Combine
@testable import PlanetList

class PlanetsViewModelTest: XCTestCase {
    
    var planetsViewModel: PlanetsViewModel!
    private var cancellables : Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        planetsViewModel = PlanetsViewModel(httpHandler: MockHttpRequestHandler())
    }
    
    override func tearDown() {
        super.tearDown()
        planetsViewModel = nil
    }
    
    func testLoadPlanetsSuccessfully(){
        
        let expectation = XCTestExpectation(description: "testLoadPlanetsSuccessfully")
        
        planetsViewModel.getPlanets()
        
        planetsViewModel
            .$planets
            .sink { value in
                XCTAssertEqual(value.count, 3)
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
}
