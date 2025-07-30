//
//  CountrySearchViewModel.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import Foundation
import Combine

class CountriesSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var selectedCountries: [Country] = []
    @Published var searchResults: [Country] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let useCases: CountriesUseCases
    let router: CountriesSearchRouter
    
    var shouldDisableNewSelection: Bool {
        selectedCountries.count >= 5
    }

    init(useCases: CountriesUseCases, router: CountriesSearchRouter) {
        self.useCases = useCases
        self.router = router
        
        $searchText
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] text in
                self?.isSearching = !text.isEmpty
            })
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] query in
                Task {
                    do {
                        let countries = try await self?.useCases.fetchCountries.execute(keyword: query)
                        Task {@MainActor in
                            self?.searchResults = countries ?? []
                        }
                    } catch (let error) {
                        debugPrint("error is \(error)") // Should show pop up
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func selectCountry(_ country: Country) {
        guard !selectedCountries.contains(country), !shouldDisableNewSelection   else { return }

        selectedCountries.append(country)
        searchResults = []
        searchText = ""
        isSearching = false
        
        Task {
         try await useCases.saveCountry.execute(country: country)
        }
    }
    
    func isCountrySelected(_ country: Country) -> Bool {
        selectedCountries.contains(country)
    }
    
    func removeSelected(at offsets: IndexSet) {
        selectedCountries.remove(atOffsets: offsets)
    }
    
    func didTapMyCountry(country: Country) {
        self.router.didTapMyCountry(country)
    }
    
    func onAppear() {
        loadCachedCountries()
    }
    
    // MARK: - Private Methods
    private func loadCachedCountries() {
        Task {
         let cachedCountries = try await self.useCases.getCachedCountries.execute()
            Task {@MainActor in
                self.selectedCountries = cachedCountries
            }
        }
    }
}
