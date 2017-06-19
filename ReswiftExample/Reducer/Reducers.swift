//
//  LoadingReducer.swift
//  ReswiftExample
//
//  Created by Ivan Foong Kwok Keong on 16/6/17.
//  Copyright © 2017 ivanfoong. All rights reserved.
//

import ReSwift

// the reducer is responsible for evolving the application state based
// on the actions it receives
func appStateReducer(action: Action, state: AppState?) -> AppState {
    // if no state has been provided, create the default state
    var state = state ?? AppState()
    
    switch action {
    case _ as APIStartLoading:
        state.isLoading = true
    case let action as APILoaded:
        state.isLoading = false
        state.usdPrice = action.usdPrice
    default:
        break
    }
    
    return state
}

