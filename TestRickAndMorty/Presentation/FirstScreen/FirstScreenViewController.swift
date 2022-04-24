//
//  FirstScreenViewController.swift
//  TestRickAndMorty
//
//  Created by Семён Соколов on 23.04.2022.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    //MARK: - UI
    @IBOutlet weak var charactersTableView: UITableView!
    
    //MARK: - Properties
    private var characters = [Character]() {
        didSet {
            charactersTableView.reloadData()
        }
    }
    
    var isNeedToLoadMoreData: Bool = true
    
    //MARK: - View life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        NetworkService.shared.getListOfCharacter(firstPage: false) { characters in
            self.characters.append(contentsOf: characters)
        }
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
    }
    
    //MARK: - func to register xib
    private func registerXib() {
        charactersTableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

// MARK: - UITableViewDataSource
extension FirstScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        cell.configureCell(character: characters[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isNeedToLoadMoreData == true {
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if distanceFromBottom < height {
                NetworkService.shared.getListOfCharacter(firstPage: true) { [weak self] result in
                    if NetworkService.shared.isLastPage == false {
                        self?.characters.append(contentsOf: result)
                    } else {
                        self?.characters.append(contentsOf: result)
                        self?.isNeedToLoadMoreData = false
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension FirstScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondScreenViewController = storyboard?.instantiateViewController(withIdentifier: "second") as! SecondScreenViewController
        secondScreenViewController.characterID = characters[indexPath.row].id
        tableView.deselectRow(at: indexPath, animated: true)
        present(secondScreenViewController, animated: true)
    }
}
