//
//  CountriesUseCases.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/30/25.
//

struct CountriesUseCases {
    let fetchCountries: DefaultFetchCountriesUseCase
    let saveCountry: SaveCountryUseCase
    let getCachedCountries: GetCachedCountriesUseCase
}
