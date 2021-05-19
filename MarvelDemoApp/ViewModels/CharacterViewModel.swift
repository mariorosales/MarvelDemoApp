//
//  CharacterViewModel.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Foundation
import Combine

final class CharacterViewModel : BaseViewModel {
    
    private var character: Character?
    private var id: Int!
    
    init(with id: Int) {
        self.id = id
    }
    
    public func loadCharacter() {
        
        do {
            self.status = .loading
            MarvelService.character(id: self.id).sink { (result) in
                switch result {
                case .failure(let error):
                    switch error {
                    case .server(code: let code, message: let reason):
                        print("Server error: \(code), reason: \(reason)")
                    case .decoding:
                        print("Decoding error \(error)")
                    }
                    self.status = .failed
                    default: break
                }
                
            } receiveValue: { (characters) in
                self.character = characters.characters()?.first
                self.status = .ready
            }.store(in: &cancellable)
        }
    }
    
    public func characterName() -> String {
        return character?.name ?? " - "
    }
    
    public func characterImagePath() -> String? {
        return character?.getThumbnailPath()
    }
    
    public func characterDescription() -> String {
        return character?.description ?? " - "
    }
}
