//
//  extentions.swift
//  taxi-app-swiftui
//
//  Created by Nikolai Margenov on 4.11.24.
//

import Foundation

extension String {
    func translated(to language: String) -> String{
        if let path = Bundle.main.path(forResource: language, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        return ""
    }
}
