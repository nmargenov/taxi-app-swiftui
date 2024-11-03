//
//  Calculator.swift
//  map-uper-test
//
//  Created by Nikolai Margenov on 2.11.24.
//

import Foundation
import SwiftUI

class CalculatorManager {
    @AppStorage("PricePerKm") private var pricePerKm = 2.4
    @AppStorage("PricePerMinute") private var pricePerMinute = 0.4

    func calculateKmPrice(meters: Double) -> Double{
        let km = meters / 1000
        let price = km * pricePerKm
        print(pricePerKm)
        return price
    }
    
    func timePrice(time: Int) -> Double{
        let minutes = time / 60
        let price = Double(minutes) * pricePerMinute
        print(pricePerMinute)
        return price
    }
    
}
