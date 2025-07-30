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
    let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CountryEntity.self
        ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

        var body: some Scene {
            WindowGroup {
                Navigator(navigationManager: navigationManager) {
                    CountriesSearchView(viewModel: CountriesSearchFactory.makeCountriesSearchViewModel(navigationManager: navigationManager, modelContext: sharedModelContainer.mainContext))
                }
            }
            .modelContainer(sharedModelContainer)
        }
    }
