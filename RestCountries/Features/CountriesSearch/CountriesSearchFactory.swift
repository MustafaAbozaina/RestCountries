//
//  CountriesSearchFactory.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//
import Foundation
import SwiftData

class CountriesSearchFactory {
    static func makeCountriesSearchViewModel(navigationManager: NavigationManager, modelContext: ModelContext) -> CountriesSearchViewModel {
        let network = NetworkManager(session: URLSession.shared)
        let remoteDataSource = DefaultCountriesRemoteDataSource(networkService: network)
        let localDataSource = DefaultCountriesLocalDataSource(context: modelContext)
        let repo = DefaultCountriesRepository(dataSources: [remoteDataSource, localDataSource])
        let fetchCountriesUseCase = DefaultFetchCountriesUseCase(repository: repo)
        let saveCountryUseCase: SaveCountryUseCase = DefaultSaveCountryUseCase(repository: repo)
        let getCachedCountriesUseCase = DefaultGetCachedCountriesUseCase(repository: repo)
        let router = DefaultCountriesSearchRouter(navigationManager: navigationManager)
        let useCases = CountriesUseCases(fetchCountries: fetchCountriesUseCase, saveCountry: saveCountryUseCase, getCachedCountries: getCachedCountriesUseCase)
        let viewModel = CountriesSearchViewModel(useCases: useCases, router: router)
        return viewModel
    }
}
