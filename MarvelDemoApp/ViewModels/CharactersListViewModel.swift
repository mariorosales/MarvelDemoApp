//
//  CharactersListViewModel.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Foundation
import Combine

final class CharactersListViewModel : BaseViewModel {
    
    public typealias CharacterListItem = (name: String, thumb: String?)
    
    private var characters:[Character]? = []
    private var searchTerm: String? = nil
    var loadedPage:Int = 0
    
    public func loadCharacters(_ searchString: String? = nil) {

        do {
            
            evalSearchTerm(searchString)
            self.status = .loading
            
            MarvelService.characters(page: loadedPage, searchString: searchTerm).sink { (result) in
                
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
                
            } receiveValue: { (response) in
                
                guard response.count() != 0 else { return }
                
                if self.loadedPage == 0 {
                    self.characters = response.characters()
                } else if let moreResults = response.characters() {
                    self.characters?.append(contentsOf: moreResults)
                }
                self.loadedPage = self.loadedPage + 1
                self.status = .ready
            }.store(in: &cancellable)
        }
    }
    
    private func evalSearchTerm(_ searchString: String? = nil) {
        if searchString != nil && searchString != searchTerm {
            reset()
            searchTerm = searchString
        }
    }
    
    private func reset() {
        loadedPage = 0
        searchTerm = nil
        characters = []
    }
    
    public func restartCharacterslist() {
        reset()
        loadCharacters()
    }
    
    public func charactersCount() -> Int {
        return characters?.count ?? 0
    }
    
    public func characterListItem(for indexPath: IndexPath) -> CharacterListItem {
        let thumb = characters?[safe: indexPath.item]?.getThumbnailPath()
        let name = characters?[safe: indexPath.item]?.name ?? " - "
        
        if indexPath.item == charactersCount() - 1 {
            self.loadCharacters()
        }
        
        return (name, thumb)
    }
    
    public func characterID(for indexPath: IndexPath) -> Int? {
        return characters?[safe: indexPath.item]?.id
    }
    
    deinit {
        cancellable.removeAll()
    }
}
