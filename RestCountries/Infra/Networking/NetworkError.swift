//
//  NetworkError.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

enum NetworkError: Error, Equatable {
    case statusCode(Int)
    case decoding(Error)
    case custom(Error)
    case invalidURL

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case let (.statusCode(a), .statusCode(b)):
            return a == b
        default:
            return false
        }
    }
}
