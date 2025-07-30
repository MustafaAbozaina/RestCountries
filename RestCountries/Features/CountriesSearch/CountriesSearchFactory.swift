//
//  CountriesSearchFactory.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//
import Foundation

class CountriesSearchFactory {
    static func makeCountriesSearchViewModel(navigationManager: NavigationManager) -> CountriesSearchViewModel {
        let network = NetworkManager(session: URLSession.shared)
        let remoteDataSource = DefaultCountriesRemoteDataSource(networkService: network)
        let repo = DefaultCountriesRepository(remoteDataSource: remoteDataSource)
        let useCase = DefaultGetCountriesUseCase(repository: repo)
        let router = DefaultCountriesSearchRouter(navigationManager: navigationManager)
        let viewModel = CountriesSearchViewModel(getCountriesUseCase: useCase, router: router)
        return viewModel
    }
}
