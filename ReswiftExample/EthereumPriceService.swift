//
//  EthereumPriceService.swift
//  Instagram Reswift
//
//  Created by Ivan Foong Kwok Keong on 19/6/17.
//  Copyright © 2017 ivanfoong. All rights reserved.
//

import Foundation
import ReSwift

class EthereumPriceService: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    static let shared = EthereumPriceService()
    var api: EthereumPriceServiceAPI
    var store: Store<StoreSubscriberStateType>
    
    init(store: Store<StoreSubscriberStateType> = mainStore, api: EthereumPriceServiceAPI = CoinMarketCapAPI()) {
        self.api = api
        self.store = store
        self.store.subscribe(self)
    }
    
    // MARK: - StoreSubscriber
    func newState(state: AppState) {
        if state.isLoading {
            self.api.ethereumPrice { usdPrice in
                self.store.dispatch(APILoaded(usdPrice: usdPrice))
            }
        }
    }
}
