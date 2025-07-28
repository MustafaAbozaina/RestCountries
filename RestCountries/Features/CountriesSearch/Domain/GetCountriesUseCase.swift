//
//  GetCountriesUseCase.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

protocol GetCountriesUseCase {
    func fetchCountries(keyword: String) async throws -> [Country]
}

class DefaultGetCountriesUseCase: GetCountriesUseCase {
    let repository: CountriesRepository

    init(repository: CountriesRepository) {
        self.repository = repository
    }

    func fetchCountries(keyword: String) async throws -> [Country] {
        try await repository.getCountries(keyword: keyword)
    }
}
