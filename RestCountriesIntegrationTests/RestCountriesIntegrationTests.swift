//
//  RestCountriesIntegrationTests.swift
//  RestCountriesIntegrationTests
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import XCTest
@testable import RestCountries

final class CountriesRemoteDataSourceIntegrationTests: XCTestCase {
    
    func testSearchCountries_realAPI_returnsResults() async throws {
        let network = NetworkManager(session: URLSession.shared)
        let dataSource = DefaultCountriesRemoteDataSource(networkService: network)
        
        do {
            let results = try await dataSource.searchCountries(keyword: "egypt")
            XCTAssertFalse(results.isEmpty, "Expected results for 'egypt', got empty array")
        } catch {
            XCTFail("Expected successful response, got error: \(error)")
        }
    }
}
