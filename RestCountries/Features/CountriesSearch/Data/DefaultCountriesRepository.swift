//
//  DefaultCountryRepository.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import SwiftData

class DefaultCountriesRepository: CountriesRepository {
    private(set) var dataSources: [CountriesDataSource]
    
    init(dataSources: [CountriesDataSource]) {
        self.dataSources = dataSources
    }

    func getCountries(keyword: String) async throws -> [Country] {
        guard let remoteDataSource = dataSources.compactMap({$0 as? CountriesRemoteDataSource}).first else {
            throw CountriesRepositoryError.noDataSourceFound
        }
        let countries: [CountryDTO] = try await remoteDataSource.searchCountries(keyword: keyword)
        return countries.map({$0.toDomain()})
    }
    
    func saveFavoriteCountry(_ country: Country) throws {
        guard let localDataSource = dataSources.compactMap({$0 as? CountriesLocalDataSource}).first else {
            throw CountriesRepositoryError.noDataSourceFound
        }
        Task {
            try await localDataSource.saveCountry(country)
        }
    }
    
    func getCachedCountries() throws -> [Country] {
        guard let localDataSource = dataSources.compactMap({$0 as? CountriesLocalDataSource}).first else {
            throw CountriesRepositoryError.noDataSourceFound
        }
        return try localDataSource.getCachedCountries()
    }
}

enum CountriesRepositoryError: Error, Equatable {
    case noDataSourceFound
}
