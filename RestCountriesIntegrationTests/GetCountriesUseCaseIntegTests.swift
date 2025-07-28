//
//  Untitled.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//
import XCTest
@testable import RestCountries


final class GetCountriesUseCaseIntegrationTests: XCTestCase {
    
    func testGetCountriesUseCase_realAPI_returnsResults() async throws {
        let network = NetworkManager(session: URLSession.shared)
        let remoteDataSource = DefaultCountriesRemoteDataSource(networkService: network)
        let repo = DefaultCountriesRepository(remoteDataSource: remoteDataSource)
        let useCase = DefaultGetCountriesUseCase(repository: repo)
        
        do {
            let results = try await useCase.fetchCountries(keyword: "USA")
            XCTAssertFalse(results.isEmpty, "Expected results for 'USA', got empty array")
        } catch {
            XCTFail("Expected successful response, got error: \(error)")
        }
    }
}
