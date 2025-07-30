//
//  CountriesRemoteDS.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import Foundation

protocol CountriesRemoteDataSource: CountriesDataSource {
    func searchCountries(keyword: String) async throws -> [CountryDTO]
}

final class DefaultCountriesRemoteDataSource: CountriesRemoteDataSource {
    private let networkService: NetworkClient

    init(networkService: NetworkClient) {
        self.networkService = networkService
    }

    func searchCountries(keyword: String) async throws -> [CountryDTO] {
        let endpoint = Endpoint(
            path: "name/\(keyword)",
            method: .get
        )
        
        let countries: [CountryDTO] = try await networkService.request(endpoint)
        return countries
    }
}
