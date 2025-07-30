//
//  CountriesSearchRepo.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

protocol CountriesRepository {
    func getCountries(keyword: String) async throws -> [Country]
    func saveFavoriteCountry(_ country: Country) throws
    func getCachedCountries() throws -> [Country]
}

