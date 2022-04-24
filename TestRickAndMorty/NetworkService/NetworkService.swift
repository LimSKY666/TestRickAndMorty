//
//  NetworkService.swift
//  TestRickAndMorty
//
//  Created by Семён Соколов on 23.04.2022.
//
import Foundation
import Alamofire

class NetworkService {
    
    //MARK: - Properties
    static let shared = NetworkService()
    private let mainURL = "https://rickandmortyapi.com/api/character"
    private let headers: HTTPHeaders = ["Content-type" : "application/json"]
    private var currentPage = "https://rickandmortyapi.com/api/character"
    private var nextPageURL: String?
    private var isFetchInProgress = false
    var isLastPage = false
    
    //MARK: - Get character by ID
    func getCharacterById(id: String, completion: @escaping(Character) -> Void) {
        DispatchQueue.main.async {
            let url = self.mainURL + "/\(id)"
            AF.request(url, method: .get, headers: self.headers).responseDecodable(of: Character.self) { response in
                switch response.result {
                case .success(let character):
                    completion(character)
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
    //MARK: - Get character list
    func getListOfCharacter(firstPage: Bool, completion: @escaping(([Character]) -> Void)) {
        guard !isFetchInProgress else { return }
        if let nextPageURL = self.nextPageURL, firstPage {
            self.currentPage = nextPageURL
        }
        self.isFetchInProgress = true
        AF.request(self.currentPage, method: .get, headers: self.headers).responseDecodable(of: ListOfCharacters.self) { response in
            switch response.result {
            case .success(let characters):
                let list = characters.results
                self.nextPageURL = characters.info.next
                if self.nextPageURL == nil {
                    self.isLastPage = true
                }
                self.isFetchInProgress = false
                completion(list)
            case .failure(let error):
                print(error)
                self.isFetchInProgress = false
            }
        }
    }
}
