//
//  Actions.swift
//  ReswiftExample
//
//  Created by Ivan Foong Kwok Keong on 16/6/17.
//  Copyright © 2017 ivanfoong. All rights reserved.
//

import ReSwift

// all of the actions that can be applied to the state
struct APIStartLoading: Action {}
struct APILoaded: Action {
    let usdPrice: Double?
}

