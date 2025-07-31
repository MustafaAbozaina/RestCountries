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
    let repository: CountriesRemoteRepository

    init(repository: CountriesRemoteRepository) {
        self.repository = repository
    }

    func execute(keyword: String) async throws -> [Country] {
        try await repository.fetchRemoteCountries(keyword: keyword)
    }
}
