//
//  CountryDetailsView.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import SwiftUI

struct CountryDetailsView: View {
    let country: Country
    
    var body: some View {
        Text("Country: \(country.name)\nCity: \(country.capital ?? "")\nCurrency: \(country.currency ?? "")")
    }
}
