//
//  NetworkManager.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//
import Foundation

protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class NetworkManager: NetworkClient {
    private let session: HTTPClient

    init(session: HTTPClient = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }

        do {
            let data =  try JSONDecoder().decode(T.self, from: data)
            return data
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}
