//
//  DomainMappable.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/30/25.
//

protocol DomainMappable<E> {
    associatedtype E
    func toDomain() -> E
}
