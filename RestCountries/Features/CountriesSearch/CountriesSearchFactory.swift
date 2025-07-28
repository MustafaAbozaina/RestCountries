//
//  CountriesSearchFactory.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//
import Foundation

class CountriesSearchFactory {
    static func makeCountriesSearchViewModel() -> CountriesSearchViewModel {
        let network = NetworkManager(session: URLSession.shared)
        let remoteDataSource = DefaultCountriesRemoteDataSource(networkService: network)
        let repo = DefaultCountriesRepository(remoteDataSource: remoteDataSource)
        let useCase = DefaultGetCountriesUseCase(repository: repo)
        let viewModel = CountriesSearchViewModel(getCountriesUseCase: useCase)
        return viewModel
    }
}
