//
//  CoinModel.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import ObjectMapper

struct CoinModel: Mappable {
    
                                // "id": "bitcoin",
    var name: String?           //"name": "Bitcoin",
    var symbol: String?         //"symbol": "BTC",
    var rank: String?           //"rank": "1",
    var usdPrice: String?       //"price_usd": "573.137",
    var euroPrice: String?      //"price_usd": "573.137",
    var tryPrice: String?       //"price_usd": "573.137",
    var krwPrice: String?       //"price_usd": "573.137",
    var rublePrice: String?       //"price_usd": "573.137",
    var lastUpdated: String?    //"last_updated": "1472762067"
                                //"price_btc": "1.0",
                                //"24h_volume_usd": "72855700.0",
                                //"market_cap_usd": "9080883500.0",
                                //"available_supply": "15844176.0",
                                //"total_supply": "15844176.0",
                                //"percent_change_1h": "0.04",
                                //"percent_change_24h": "-0.3",
                                //"percent_change_7d": "-0.57",
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name            <- map["name"]
        symbol          <- map["symbol"]
        rank            <- map["rank"]
        usdPrice        <- map["price_usd"]
        euroPrice       <- map["price_eur"]
        tryPrice        <- map["price_try"]
        krwPrice        <- map["price_krw"]
        rublePrice      <- map["price_rub"]
        lastUpdated     <- map["last_updated"]
    }
}
