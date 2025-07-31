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
    
    lazy var localDataSource: CountriesLocalDataSource = {
        dataSources.compactMap { $0 as? CountriesLocalDataSource }.first!
    }()
    
    lazy var remoteDataSource: CountriesRemoteDataSource? = {
        dataSources.compactMap { $0 as? CountriesRemoteDataSource }.first!
    }()

    func fetchRemoteCountries(keyword: String) async throws -> [Country] {
        let countries: [CountryDTO]? = try await remoteDataSource?.searchCountries(keyword: keyword)
        return countries?.map({$0.toDomain()}) ?? []
    }
    
    func saveFavoriteCountry(_ country: Country) throws {
        Task {
            try await localDataSource.saveCountry(country)
        }
    }
    
    func getCachedCountries() throws -> [Country] {
        return try localDataSource.getCachedCountries()
    }
    
    func deleteCountry(_ country: Country) throws {
        Task {
            try await localDataSource.saveCountry(country)
        }
    }
}
