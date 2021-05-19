//
//  Collection.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
