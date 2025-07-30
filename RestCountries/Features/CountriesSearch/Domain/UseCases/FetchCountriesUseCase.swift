//
//  GetCountriesUseCase.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//


protocol FetchCountriesUseCase {
    func execute(keyword: String) async throws -> [Country]
}

class DefaultFetchCountriesUseCase: FetchCountriesUseCase {
    let repository: CountriesRepository

    init(repository: CountriesRepository) {
        self.repository = repository
    }

    func execute(keyword: String) async throws -> [Country] {
        try await repository.getCountries(keyword: keyword)
    }
}
