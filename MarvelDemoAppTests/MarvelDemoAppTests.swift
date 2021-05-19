//
//  MarvelDemoAppTests.swift
//  MarvelDemoAppTests
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import XCTest
import Combine
@testable import MarvelDemoApp
    
class MarvelDemoAppTests: XCTestCase {
    var cancellable:AnyCancellable!

    func testLoadCharacters() throws {
        
        let viewModel = CharactersListViewModel()
        let expectation = self.expectation(description: "waiting validation")

        cancellable = viewModel.$status.sink { (result) in
            
            switch result {
            case .failure(_):
                XCTFail("Error during load Characters")
            default: break
            }
            
        } receiveValue: { (status:ViewModelStatus) in
            guard status == .ready else { return }
            expectation.fulfill()
        }
        
        viewModel.loadCharacters()

        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(viewModel.charactersCount() > 0)
    }
    
    func testLoadCharacter() throws {
        
        let id:Int = 1017100
        let characterName:String = "A-Bomb (HAS)"
        let viewModel = CharacterViewModel(with: id)
        let expectation = self.expectation(description: "waiting validation")
        
        cancellable = viewModel.$status.dropFirst().sink(receiveCompletion: { (result) in
        
            switch result {
            case .failure(_):
                XCTFail("Error during load Characters")
            default: break
            }
            
        }, receiveValue: { (status:ViewModelStatus) in
            guard status == .ready else { return }
            expectation.fulfill()
        })
        
        viewModel.loadCharacter()
        
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(viewModel.characterName() == characterName)
    }
}
