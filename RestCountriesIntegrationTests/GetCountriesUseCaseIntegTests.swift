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
        let repo = DefaultCountriesRepository(dataSources: [remoteDataSource])
        let useCase = DefaultFetchCountriesUseCase(repository: repo)
        
        do {
            let results = try await useCase.execute(keyword: "USA")
            XCTAssertFalse(results.isEmpty, "Expected results for 'USA', got empty array")
        } catch {
            XCTFail("Expected successful response, got error: \(error)")
        }
    }
}
