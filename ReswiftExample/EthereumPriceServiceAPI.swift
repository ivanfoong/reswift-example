//
//  EthereumPriceServiceAPI.swift
//  Instagram Reswift
//
//  Created by Ivan Foong Kwok Keong on 19/6/17.
//  Copyright © 2017 ivanfoong. All rights reserved.
//

import Foundation

protocol EthereumPriceServiceAPI {
    func ethereumPrice(completion: @escaping (Double?) -> Void)
}
