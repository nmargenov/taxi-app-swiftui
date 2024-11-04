//
//  Consnats.swift
//  taxi-app-swiftui
//
//  Created by Nikolai Margenov on 4.11.24.
//

import Foundation

class K {
    static let title = "Taxi app"
    
    struct DefaultValue{
        static let pricePerKm = 2.4
        static let pricePerMin = 0.4
        static let language = "en"
        static let currency = "$"
    }
    
    struct Keys {
        static let kmKey = "PricePerKm"
        static let minuteKey = "PricePerMinute"
        static let languageKey = "Language"
        static let currencyKey = "Currency"
    }
    
    struct Arrays {
        static let languagesArray = ["en","bg","de","es","fr","it","ru"]
        static let currenciesArray = ["$","€","£","лв."]
    }
}
