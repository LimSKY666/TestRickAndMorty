//
//  SecondScrennViewController.swift
//  TestRickAndMorty
//
//  Created by Семён Соколов on 23.04.2022.
//

import UIKit
import Kingfisher

class SecondScreenViewController: UIViewController {

    //MARK: - Property
    var characterID: Int?
    
    //MARK: - UI
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    //MARK: - View life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = characterID else { return }
        NetworkService.shared.getCharacterById(id: "\(id)") { [weak self] response in
            self?.configureView(character: response)
        }
    }
    
    //MARK: - Func to configure view
    private func configureView(character: Character) {
        guard let image = character.image else { return }
        characterImageView.kf.setImage(with: URL(string: image))
        nameLabel.text = character.name
        speciesLabel.text = "Species: \(character.species)"
        genderLabel.text = "Gender: \(character.gender)"
        statusLabel.text = "Status: \(character.status)"
        locationLabel.text = "Location: \(character.location.name)"
        countLabel.text = "Episodes: \(String(describing: character.episode.count))"
    }
    
}
