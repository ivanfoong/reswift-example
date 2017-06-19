//
//  CrytoCompareAPI.swift
//  Instagram Reswift
//
//  Created by Ivan Foong Kwok Keong on 19/6/17.
//  Copyright © 2017 ivanfoong. All rights reserved.
//

import Foundation

public class CrytoCompareAPI: EthereumPriceServiceAPI {
    let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD")!
    
    public func ethereumPrice(completion: @escaping (Double?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil && data != nil else { // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 { // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                if data != nil {
                    print("data = \(String(data: data!, encoding: String.Encoding.utf8)!)")
                }
            }
            
            var usdPrice: Double?
            if let priceDictionary = (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? [String: Double] {
                print("Found \(priceDictionary)")
                usdPrice = priceDictionary["USD"]
            }
            completion(usdPrice)
        }
        task.resume()
    }
}
