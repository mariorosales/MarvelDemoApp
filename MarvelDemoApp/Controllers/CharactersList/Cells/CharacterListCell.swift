//
//  CharacterListCell.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import UIKit

class CharacterListCell : UITableViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    public func load(with name: String, imageUrl: String? = nil) {
        characterImage.layer.borderColor = UIColor.darkGray.cgColor
        characterImage.loadImage(url: imageUrl)
        characterName.text = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
        characterName.text = ""
    }
    
}
