//
//  NetworkManagerTests.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//
import XCTest
@testable import RestCountries

final class NetworkManagerTests: XCTestCase {
    let anyUrl = "https://mock.com"
    
    struct MockModel: Codable, Equatable {
        let id: Int
        let name: String
    }

    func testRequest_SuccessfulDecoding() async throws {
        let expectedModel = MockModel(id: 1, name: "Test Country")
        let data = try JSONEncoder().encode([expectedModel])
        let mockClient = MockHTTPClient(mockData: data)

        let sut = NetworkManager(session: mockClient)
        let endpoint = Endpoint(path: anyUrl)

        let result: [MockModel] = try await sut.request(endpoint)

        XCTAssertEqual(result, [expectedModel])
    }
    
    func testRequest_succeeds_whenStatusCodeIs2xx() async throws {
        let statusCodes = [200, 201, 202, 204, 299]
        let mockModel = MockModel(id: 1, name: "Test Country")
        let mockData = try JSONEncoder().encode([mockModel])
        let endpoint = Endpoint(path: anyUrl)

        for statusCode in statusCodes {
            let mockClient = MockHTTPClient(mockData: mockData, statusCode: statusCode)
            let sut = NetworkManager(session: mockClient)

            do {
                let result: [MockModel] = try await sut.request(endpoint)
                XCTAssertEqual(result, [mockModel], "Expected successful response for status code \(statusCode)")
            } catch {
                XCTFail("Expected success for status code \(statusCode), but got error: \(error)")
            }
        }
    }


    func testRequest_fails_whenStatusCodeIsNot2xx() async throws {
        let statusCodes = [400, 401, 403, 404, 500]
        let endpoint = Endpoint(path: anyUrl)

        for statusCode in statusCodes {
            let mockClient = MockHTTPClient(mockData: Data(), statusCode: statusCode)
            let sut = NetworkManager(session: mockClient)

            do {
                let _: [MockModel] = try await sut.request(endpoint)
                XCTFail("Expected failure for status code \(statusCode), but succeeded")
            } catch {
                XCTAssertEqual(error as? NetworkError, NetworkError.statusCode(statusCode), "Unexpected error for status code \(statusCode)")
            }
        }
    }

}

class MockHTTPClient: HTTPClient {
    let mockData: Data
    let mockResponse: URLResponse
    let mockError: Error?
    let urlPath: String

    init(
        mockData: Data = Data(),
        statusCode: Int = 200,
        mockError: Error? = nil,
        urlPath: String = "https://example.com"
    ) {
        self.mockData = mockData
        self.mockError = mockError
        self.mockResponse = HTTPURLResponse(
            url: URL(string: urlPath)!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        self.urlPath = urlPath
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let mockError = mockError {
            throw mockError
        }
        return (mockData, mockResponse)
    }
}
