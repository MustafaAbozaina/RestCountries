//
//  CountrySearchRouter.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//


protocol CountriesSearchRouter: NavigationRouter {
    func didTapMyCountry(_ country: Country)
}

class DefaultCountriesSearchRouter: CountriesSearchRouter {
    var navigationManager: NavigationManager
    
    required init(navigationManager: NavigationManager) {
        self.navigationManager = navigationManager
    }
    
    func didTapMyCountry(_ country: Country) {
        self.navigationManager.push(.countryDetails(country))
    }
}
