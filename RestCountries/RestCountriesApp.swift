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
    @ObservedObject private var countriesSearchViewModel: CountriesSearchViewModel
    
    init() {
        let navigation = NavigationManager()
        _navigationManager = StateObject(wrappedValue: navigation)
        self.countriesSearchViewModel =  CountriesSearchFactory.makeCountriesSearchViewModel(navigationManager: navigation)
    }
    
    var body: some Scene {
        WindowGroup {
            Navigator(navigationManager: navigationManager) {
                CountriesSearchView(viewModel: countriesSearchViewModel)
            }
        }
    }
}
