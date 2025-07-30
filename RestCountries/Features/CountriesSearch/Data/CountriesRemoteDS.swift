//
//  CountriesRemoteDS.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import Foundation

protocol CountriesRemoteDataSource {
    func searchCountries(keyword: String) async throws -> [Country]
}

final class DefaultCountriesRemoteDataSource: CountriesRemoteDataSource {
    private let networkService: NetworkClient

    init(networkService: NetworkClient) {
        self.networkService = networkService
    }

    func searchCountries(keyword: String) async throws -> [Country] {
        let endpoint = Endpoint(
            path: "name/\(keyword)",
            method: .get
        )
        
        let countries: [Country] = try await networkService.request(endpoint)
        return countries
    }
}
