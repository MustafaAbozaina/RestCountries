//
//  CountrySearchView.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import SwiftUI

struct CountriesSearchView: View {
    @StateObject private var viewModel: CountriesSearchViewModel

    init(viewModel: CountriesSearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center) {
                Text("My Countries")
                    .font(.headline)
                    .padding(.top)
                
                List {
                    ForEach(viewModel.selectedCountries, id: \.self) { country in
                        Button {
                            viewModel.didTapMyCountry(country: country)
                        } label: {
                        Text("Country: \(country.name)")
                        }
                    }
                    .onDelete(perform: viewModel.removeSelected)
                }
            }
            
            if viewModel.isSearching && !viewModel.searchResults.isEmpty {
                List {
                    ForEach(viewModel.searchResults, id: \.self) { country in
                        Button {
                            viewModel.selectCountry(country)
                        } label: {
                            HStack {
                                Text(country.name)
                                    .foregroundColor(viewModel.isCountrySelected(country) ? .gray : .primary)
                                Spacer()
                                if viewModel.isCountrySelected(country) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .disabled(viewModel.isCountrySelected(country))
                    }
                }
                .listStyle(PlainListStyle())
                .frame(height: 200)
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
                .transition(.opacity)
                .zIndex(1)
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search countries")
        .onAppear {
            viewModel.onAppear()
        }
    }
}
