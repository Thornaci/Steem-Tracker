//
//  CurrencyTypes.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

enum CurrencyTypes: String {
    
    case dolar = "usd"
    case euro = "eur"
    case turkishLiras = "try"
    case ruble = "rub"
    case koreanWon = "krw"
    case noType = "nothing"
}

enum CurrencySymbol: String {
    
    case dolar = "$"
    case euro = "€"
    case turkishLiras = "₺"
    case ruble = "₽"
    case koreanWon = "₩"
}

typealias money = Double
