//
//  EthereumPriceServiceTests.swift
//  Instagram ReswiftTests
//
//  Created by Ivan Foong Kwok Keong on 19/6/17.
//  Copyright © 2017 ivanfoong. All rights reserved.
//

import XCTest
@testable import ReswiftExample
import ReSwift

class MockEthereumPriceServiceAPI: EthereumPriceServiceAPI {
    var expectation: XCTestExpectation
    var price: Double?
    
    init(expectation: XCTestExpectation, mockPrice: Double?) {
        self.expectation = expectation
        self.price = mockPrice
    }
    
    func ethereumPrice(completion: @escaping (Double?) -> Void) {
        completion(price)
        expectation.fulfill()
    }
}

class EthereumPriceServiceTests: XCTestCase {
    var didDispatchAPILoaded = false
    var retrievedUSDPrice: Double? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPIStartLoadingToAPISuccessfullyLoaded() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expect = expectation(description: "should call dispatch(APILoaded(usdPrice:))")
        let expectedUSDPrice = 12.34
        let mockAPI = MockEthereumPriceServiceAPI(expectation: expect, mockPrice: expectedUSDPrice)
        let store = Store<AppState>(
            reducer: mockReducer,
            state: nil
        )
        let service = EthereumPriceService(store: store, api: mockAPI)
        
        store.dispatch(APIStartLoading())
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.didDispatchAPILoaded)
            XCTAssertEqual(expectedUSDPrice, self.retrievedUSDPrice)
        }
    }
    
    func testAPIStartLoadingToAPIFailedToLoad() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expect = expectation(description: "should call dispatch(APILoaded(usdPrice:))")
        let mockAPI = MockEthereumPriceServiceAPI(expectation: expect, mockPrice: nil)
        let store = Store<AppState>(
            reducer: mockReducer,
            state: nil
        )
        let service = EthereumPriceService(store: store, api: mockAPI)
        
        store.dispatch(APIStartLoading())
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.didDispatchAPILoaded)
            XCTAssertNil(self.retrievedUSDPrice)
        }
    }
    
    func mockReducer(action: Action, state: AppState?) -> AppState {
        switch action {
        case _ as APIStartLoading:
            self.didDispatchAPILoaded = true
        default:
            break
        }
        let resultingAppState = appStateReducer(action: action, state: state)
        self.retrievedUSDPrice = resultingAppState.usdPrice
        return resultingAppState
    }
    
}

