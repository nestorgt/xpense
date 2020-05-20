//
//  IntegrationTests.swift
//  IntegrationTests
//
//  Created by Nestor Garcia on 20/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

final class APIServiceTests: XCTestCase {

    var apiService: APIService!
    var result: Result<Data, APIError>!
    
    override func setUp() {
        super.setUp()
        apiService = APIService()
        
    }
    
    func testRequestSuccess() throws {
        performAndWait(for: URLRequest(url: URL(string: "https://www.google.com")!),
                       with: XCTestExpectation(description: "Performs a request"))
        
        XCTAssertTrue(result.isSuccess)
    }
    
    func testRequestFailure_InsecureConnection() throws {
        performAndWait(for: URLRequest(url: URL(string: "http://www.google.com")!),
                       with: XCTestExpectation(description: "Performs a request"))
        
        XCTAssertTrue(result.isFailure)
    }
    
    func testRequestFailure_NotFound() throws {
        performAndWait(for: URLRequest(url: URL(string: "https://www.google.com/notfound")!),
                       with: XCTestExpectation(description: "Performs a request"))
        
        XCTAssertTrue(result.error as? APIError == APIError.notFound)
    }
    
    private func performAndWait(for urlRequest: URLRequest, with expectation: XCTestExpectation) {
        apiService.perform(urlRequest: urlRequest) { [weak self] result in
            self?.result = result
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
