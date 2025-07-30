//
//  Navigator.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import SwiftUI

struct Navigator<Content: View>: View {
    @ObservedObject var navigationManager: NavigationManager
    var content: () -> Content
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            content()
                .navigationDestination(for: NavigationTarget.self) { target in
                    switch target {
                    case .countryDetails(let country):
                        CountryDetailsView(country: country)
                    }
                }
        }
    }
}
