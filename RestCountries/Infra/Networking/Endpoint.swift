//
//  Endpoint.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//
import Foundation

struct Endpoint {
    let baseUrl: URL
    let path: String?
    let method: HTTPMethod
    let headers: [String: String]

    var url: URL? {
        if let path = path {
            return baseUrl.appendingPathComponent(path)
        } else {
            return nil
        }
    }

    init(
        baseUrl: URL = URL(string: "https://restcountries.com/v2/")!,
        path: String? = nil,
        method: HTTPMethod = .get,
        headers: [String: String] = ["Accept": "application/json"]
    ) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.headers = headers
    }

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
}
