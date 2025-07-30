//
//  CountryDTO.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/30/25.
//
import Foundation

struct CountryDTO: Decodable {
    let id: String
    let name: String
    let capital: String?
    let flagURL: String?
    
    var currency: String? {
        return currencies?.first?.code
    }
    private let currencies: [Currency]?
    
    enum CodingKeys: String, CodingKey {
        case id = "alpha3Code"
        case name, flagURL, capital, currencies
    }
    
    struct Currency: Decodable, Hashable {
        let code: String?
        let name: String?
        let symbol: String?
    }
}

extension CountryDTO: DomainMappable {
    func toDomain() -> Country {
        return Country(id: id, name: name, capital: capital, flagURL: flagURL, currency: currency)
    }
}
