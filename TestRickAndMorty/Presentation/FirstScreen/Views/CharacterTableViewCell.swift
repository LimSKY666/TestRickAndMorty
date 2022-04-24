//
//  CharacterTableViewCell.swift
//  TestRickAndMorty
//
//  Created by Семён Соколов on 23.04.2022.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {

    //MARK: - UI
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Func to configure character cell
    func configureCell(character: Character) {
        guard let image = character.image else { return }
        let imageURL = URL(string: image)
        nameLabel.text = character.name
        speciesLabel.text = character.species
        genderLabel.text = character.gender
        characterImageView.kf.setImage(with: imageURL)
    }
}
