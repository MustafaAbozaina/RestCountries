//
//  CountriesSearchRepo.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

protocol CountriesCachingRepository {
    func saveFavoriteCountry(_ country: Country) throws
    func getCachedCountries() throws -> [Country]
    func deleteCountry(_ country: Country) throws
}

protocol CountriesRemoteRepository {
    func fetchRemoteCountries(keyword: String) async throws -> [Country]
}
