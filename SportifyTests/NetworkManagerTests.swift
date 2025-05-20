//
//  SportifyTests.swift
//  SportifyTests
//
//  Created by Ahmed on 5/20/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import XCTest
@testable import Sportify

class NetworkManagerTests: XCTestCase {

    var networkService: NetworkManagerProtocol!
    
    override func setUp() {
        networkService = NetworkManager()
    }

    override func tearDown() {
        networkService = nil
    }
    

    func testFetchEvents() {
        
        let exp = expectation(description: "Waiting")
       
        
//        NetworkManager.fetchEvents(from: "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Leagues&APIkey=\("9fa12a9cabfb50c611c248b506b791b187035a8b5d3a288ada3dbce4ba74ecb1")" { events, error in
//
//            if let error = error {
//                XCTFail()
//            } else {
//                XCTAssert(events.)
//                exp.fulfill()
//            }
//            
//        }
        waitForExpectations(timeout: 5)
        
    }
   
    
    

   

}
