//
//  ContentView.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        let network = NetworkManager(session: URLSession.shared)
        let remoteDataSource = DefaultCountriesRemoteDataSource(networkService: network)
        let repo = DefaultCountriesRepository(remoteDataSource: remoteDataSource)
        let useCase = DefaultGetCountriesUseCase(repository: repo)
        NavigationStack {
            CountriesSearchView(viewModel: CountriesSearchViewModel(getCountriesUseCase: useCase))
        }
    }
}

#Preview {
    ContentView()
}
