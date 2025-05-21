//
//  SportifyTests.swift
//  SportifyTests
//
//  Created by Ahmed on 5/20/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import XCTest
@testable import Sportify

final class NetworkServiceTests: XCTestCase {

    var networkService: FakeNetworkService!

    override func setUp() {
        super.setUp()
        networkService = FakeNetworkService()
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    // MARK: - Events

   ////////////////////

    // MARK: - Players

    func testFetchPlayersSuccess() {
        networkService.shouldReturnError = false
        networkService.mockPlayers = fakePlayers

        let expectation = expectation(description: "Players Success")

        networkService.fetchPlayers(from: "mock-url") { result in
            switch result {
            case .success(let players):
                XCTAssertEqual(players.count, 2)
                XCTAssertEqual(players.first?.player_name, "John Test")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testFetchPlayersFailure() {
        networkService.shouldReturnError = true

        let expectation = expectation(description: "Players Failure")

        networkService.fetchPlayers(from: "mock-url") { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    //////////////////////
   
    ///////////////////

    
    
    func testNetworkService_fetchPlayers_returnsValidData() {
        let service = NetworkService()
        let expectation = expectation(description: "Players API")

        let apiKey = service.apiKey
        let url = "https://apiv2.allsportsapi.com/football/?met=Players&teamId=81&APIkey=\(apiKey)"

        service.fetchPlayers(from: url) { result in
            switch result {
            case .success(let players):
                XCTAssertGreaterThan(players.count, 0)
            case .failure(let error):
                XCTFail("API call failed: \(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    
    func testNetworkService_fetchEvents_handlesEmptyArray() {
        let service = NetworkService()
        let expectation = expectation(description: "Events API")

        let url = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=152&from=2025-12-01&to=2025-12-01&APIkey=\(service.apiKey)"

        service.fetchEvents(from: url) { result in
            switch result {
            case .success(let events):
                XCTAssertEqual(events.count, 0, "Should return empty events array")
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    
    
    func testNetworkService_fetchTeams_handlesInvalidLeagueID() {
        let service = NetworkService()
        let expectation = expectation(description: "Invalid Teams API")

        let url = "https://apiv2.allsportsapi.com/football/?met=Teams&leagueId=99999999&APIkey=\(service.apiKey)"

        service.fetchTeams(from: url) { result in
            switch result {
            case .success(let teams):
                XCTAssertEqual(teams.count, 0, "Expected empty array for invalid league ID")
            case .failure:
                XCTFail("Should not fail, just return empty list")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

}
