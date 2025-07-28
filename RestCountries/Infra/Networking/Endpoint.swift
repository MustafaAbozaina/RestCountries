//
//  Endpoint.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//
import Foundation

struct Endpoint {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]
    
    init(url: URL, method: HTTPMethod = .get, headers: [String: String] = [:]) {
        self.url = url
        self.method = method
        self.headers = headers
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
}
