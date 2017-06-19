//
//  ReswiftExampleTests.swift
//  ReswiftExampleTests
//
//  Created by Ivan Foong Kwok Keong on 19/6/17.
//  Copyright © 2017 ivanfoong. All rights reserved.
//

import XCTest
@testable import ReswiftExample

class ReswiftExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadingReducerForStartLoading() {
        let action = APIStartLoading()
        let initialAppState = AppState(isLoading: false, usdPrice: nil)
        
        let resultingAppStore = appStateReducer(action: action, state: initialAppState)
        XCTAssertTrue(resultingAppStore.isLoading)
        XCTAssertNil(resultingAppStore.usdPrice)
    }
    
    func testLoadingReducerForLoadedSuccess() {
        let usdPrice = 12.34
        let action = APILoaded(usdPrice: usdPrice)
        let initialAppState = AppState(isLoading: true, usdPrice: nil)
        
        let resultingAppStore = appStateReducer(action: action, state: initialAppState)
        XCTAssertFalse(resultingAppStore.isLoading)
        XCTAssertEqual(usdPrice, resultingAppStore.usdPrice)
    }
    
    func testLoadingReducerForLoadedFailed() {
        let action = APILoaded(usdPrice: nil)
        let initialAppState = AppState(isLoading: true, usdPrice: nil)
        
        let resultingAppStore = appStateReducer(action: action, state: initialAppState)
        XCTAssertFalse(resultingAppStore.isLoading)
        XCTAssertNil(resultingAppStore.usdPrice)
    }
}
