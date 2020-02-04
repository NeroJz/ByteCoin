//
//  CoinData.swift
//  ByteCoin
//
//  Created by Kum Hoe Lau on 04/02/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData:Decodable {
    let rate:Double
    let asset_id_quote: String
    
    var currencyLabel: String {
        return asset_id_quote
    }
}
