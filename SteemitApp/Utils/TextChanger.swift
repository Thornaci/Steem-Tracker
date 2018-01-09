//
//  TextChanger.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

struct TextChanger {
    func changeCurrency(currency: String) -> CurrencyTypes {
        switch currency {
        case "Dolar":
            return CurrencyTypes.dolar
        case "Euro":
            return CurrencyTypes.euro
        case "Turkish Liras":
            return CurrencyTypes.turkishLiras
        default:
            return CurrencyTypes.noType
        }
    }
}
