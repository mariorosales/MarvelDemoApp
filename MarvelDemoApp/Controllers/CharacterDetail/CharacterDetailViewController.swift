//
//  CharacterDetailViewController.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import UIKit
import Combine

class CharacterDetailViewController: UIViewController {
    
    private var viewModel:CharacterViewModel!
    private var cancellable:AnyCancellable?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!

    static func create(with id: Int?) -> CharacterDetailViewController? {
        guard let id = id else { return nil }
        let viewController = UIStoryboard(name: Story.Main.rawValue, bundle: nil).instantiateViewController(withIdentifier: CharacterDetailViewController.identifier) as! CharacterDetailViewController
        viewController.viewModel = CharacterViewModel(with: id)
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancellable = viewModel.$status.sink(receiveValue: { (status:ViewModelStatus) in
            guard status == .ready else { return }
            self.publish()
        })
        
        viewModel.loadCharacter()
    }
    
    private func publish() {
        
        characterImage.layer.borderColor = UIColor.lightGray.cgColor
        characterImage.loadImage(url: viewModel.characterImagePath())

        nameLabel.text = viewModel.characterName()
        descriptionLabel.text = viewModel.characterDescription()
        comicsLabel.text = viewModel.characterComics()
        seriesLabel.text = viewModel.characterSeries()
    }
    
    deinit {
        cancellable = nil
    }
    
}
