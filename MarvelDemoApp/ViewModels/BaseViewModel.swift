//
//  BaseViewModel.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 19/05/2021.
//

import Foundation
import Combine

public enum ViewModelStatus {
    case notLoaded
    case loading
    case ready
    case failed
}

class BaseViewModel {
    
    internal var cancellable: Set<AnyCancellable> = []
    @Published var status:ViewModelStatus = .notLoaded

}
