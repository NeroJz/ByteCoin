//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "1D6EBD96-6EA6-4750-8C03-1F997597E95C"

    let currencyArray = ["AUD", "BRL", "CAD",
                         "CNY", "EUR", "GBP",
                         "HKD", "IDR", "ILS",
                         "INR", "JPY", "MXN",
                         "NOK", "NZD", "PLN",
                         "RON", "RUB", "SEK",
                         "SGD", "USD", "ZAR"]
    
    var delegate:CoinManagerDelegate?
        
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString:String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let coinData = self.parseJSON(safeData) {
                        self.delegate?.successGetCoin(coinData)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}


protocol CoinManagerDelegate {
    func successGetCoin(_ coin:CoinData)
    func didFailWithError(_ error:Error)
}
