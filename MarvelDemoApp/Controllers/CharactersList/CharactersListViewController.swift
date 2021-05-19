//
//  CharactersListViewController.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import UIKit
import Combine

class CharactersListViewController: UIViewController {
    
    private var viewModel:CharactersListViewModel! = CharactersListViewModel()
    private var cancellable:AnyCancellable?
    @IBOutlet var tableView:UITableView!
    @IBOutlet var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self

        cancellable = viewModel.$status.sink(receiveCompletion: { (result) in
            
            switch result {
            case .failure(let error):
                print("Error \(error)")
            default: break
            }
            
        }, receiveValue: { [weak self] (status: ViewModelStatus) in
            guard status == .ready else { return }
            self?.tableView.reloadData()
        })
        
        viewModel.loadCharacters()
    }
    
    deinit {
        cancellable = nil
    }
}

extension CharactersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detail = CharacterDetailViewController.create(with: viewModel.characterID(for: indexPath)) else { return }
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.charactersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CharacterListCell = tableView.dequeue(for: indexPath)
        let listItem = viewModel.characterListItem(for: indexPath)
        cell.load(with: listItem.name, imageUrl: listItem.thumb)
        return cell
    }
}

extension CharactersListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 2 else { return }
        viewModel.loadCharacters(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        viewModel.restartCharacterslist()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
