//
//  RestCountriesApp.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import SwiftUI
import SwiftData

@main
struct RestCountriesApp: App {
    @StateObject private var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            Navigator(navigationManager: navigationManager) {
                CountriesSearchView(viewModel: CountriesSearchFactory.makeCountriesSearchViewModel())
            }
        }
    }
}
