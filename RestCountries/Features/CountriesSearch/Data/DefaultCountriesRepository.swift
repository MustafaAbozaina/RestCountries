//
//  DefaultCountryRepository.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

class DefaultCountriesRepository: CountriesRepository {
    let remoteDataSource: CountriesRemoteDataSource

    init(remoteDataSource: CountriesRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCountries(keyword: String) async throws -> [Country] {
        try await remoteDataSource.searchCountries(keyword: keyword)
    }
    
    func saveFavoriteCountry(_ country: Country) {
        
    }
}
